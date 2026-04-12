import Foundation

// MARK: - Sync Queue Item (Codable for persistence if needed)
struct SyncQueueItem: Codable, Identifiable {
    let id: UUID
    let action: SyncAction
    let timestamp: Date
    var retryCount: Int
    let maxRetries: Int
    let payload: Data?
    
    init(id: UUID = UUID(), action: SyncAction, timestamp: Date = Date(), retryCount: Int = 0, maxRetries: Int = AppConstants.Sync.maxRetries, data: Any) {
        self.id = id
        self.action = action
        self.timestamp = timestamp
        self.retryCount = retryCount
        self.maxRetries = maxRetries
        
        // Try to serialize arbitrary data to JSON for storage/logging
        if let encodable = data as? Encodable {
            let encoder = JSONEncoder()
            self.payload = try? encoder.encode(AnyEncodable(encodable))
        } else {
            self.payload = nil
        }
    }
}
// Wrapper to allow encoding of `Any` that conforms to Encodable at runtime
private struct AnyEncodable: Encodable {
    private let encodeFunc: (Encoder) throws -> Void
    
    init<T: Encodable>(_ wrapped: T) {
        self.encodeFunc = wrapped.encode
    }
    
    func encode(to encoder: Encoder) throws {
        try encodeFunc(encoder)
    }
}

