import Foundation

class NetworkService {
    static let shared = NetworkService()
    private let session: URLSession
    
    private init() {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = AppConstants.API.timeout
        config.timeoutIntervalForResource = AppConstants.API.timeout * 2
        config.waitsForConnectivity = true
        self.session = URLSession(configuration: config)
    }
    
    // MARK: - Generic Request Method
    func request<T: Codable>(
        endpoint: String,
        method: HTTPMethod = .get,
        body: Encodable? = nil,
        retryCount: Int = 0
    ) async throws -> T {
        guard var urlComponents = URLComponents(string: "\(AppConstants.API.baseURL)\(endpoint)") else {
            throw NetworkError.invalidURL
        }
        
        guard let url = urlComponents.url else {
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(getAuthToken())", forHTTPHeaderField: "Authorization")
        
        if let body = body {
            let encoder = JSONEncoder()
            request.httpBody = try encoder.encode(body)
        }
        
        do {
            let (data, response) = try await session.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw NetworkError.noResponse
            }
            
            guard (200...299).contains(httpResponse.statusCode) else {
                throw NetworkError.badStatusCode(httpResponse.statusCode)
            }
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            let decodedData = try decoder.decode(T.self, from: data)
            return decodedData
            
        } catch let error as NetworkError {
            if retryCount < AppConstants.API.retryCount {
                try await Task.sleep(nanoseconds: UInt64(AppConstants.API.retryDelay * 1_000_000_000))
                return try await request(endpoint: endpoint, method: method, body: body, retryCount: retryCount + 1)
            }
            throw error
        }
    }
    
    // MARK: - Helper Methods
    private func getAuthToken() -> String {
        return "default_token" // Thay bằng token thực tế
    }
    
    // MARK: - Check Internet Connection
    func isConnected() -> Bool {
        guard let reachability = try? Reachability() else { return false }
        return reachability.connection != .unavailable
    }
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
    case patch = "PATCH"
}

enum NetworkError: LocalizedError {
    case invalidURL
    case noResponse
    case badStatusCode(Int)
    case decodingError
    case encodingError
    case networkError(String)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "URL không hợp lệ"
        case .noResponse:
            return "Không nhận được phản hồi từ máy chủ"
        case .badStatusCode(let code):
            return "Lỗi máy chủ: \(code)"
        case .decodingError:
            return "Lỗi giải mã dữ liệu"
        case .encodingError:
            return "Lỗi mã hóa dữ liệu"
        case .networkError(let message):
            return "Lỗi kết nối mạng: \(message)"
        }
    }
}

class Reachability {
    static let `default` = try? Reachability()
    
    enum Connection {
        case unavailable
        case wifi
        case cellular
    }
    
    var connection: Connection {
        return .wifi // Simplified - trong thực tế sử dụng Network framework
    }
    
    init() throws { }
}
