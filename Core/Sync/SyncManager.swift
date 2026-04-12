import Foundation
import Network

class SyncManager: ObservableObject {
    static let shared = SyncManager()
    
    @Published var isSyncing = false
    @Published var lastSyncDate: Date?
    @Published var syncStatus: String = "Sẵn sàng"
    
    private let monitor = NWPathMonitor()
    private var isConnected = false
    private var syncTimer: Timer?
    private let queue = DispatchQueue(label: "com.b2b.sync")
    
    private init() {
        setupNetworkMonitoring()
    }
    
    // MARK: - Network Monitoring
    private func setupNetworkMonitoring() {
        monitor.pathUpdateHandler = { [weak self] path in
            DispatchQueue.main.async {
                self?.isConnected = (path.status == .satisfied)
                if self?.isConnected == true {
                    self?.processQueue()
                }
            }
        }
        let queue = DispatchQueue(label: "NetworkMonitor")
        monitor.start(queue: queue)
    }
    
    // MARK: - Enqueue Data
    func enqueueData(_ action: SyncAction, data: Any) {
        queue.async { [weak self] in
            guard let self = self else { return }
            
            let item = SyncQueueItem(
                id: UUID(),
                action: action,
                timestamp: Date(),
                retryCount: 0,
                maxRetries: AppConstants.Sync.maxRetries,
                data: data
            )
            
            DispatchQueue.main.async {
                self.syncStatus = "Đã thêm vào hàng đợi"
            }
            
            if self.isConnected {
                self.processQueue()
            } else {
                print(" Mạng không khả dụng - Sẽ đồng bộ khi có kết nối")
            }
        }
    }
    
    // MARK: - Process Queue
    func processQueue() {
        guard !isSyncing else { return }
        guard isConnected else { return }
        
        DispatchQueue.main.async {
            self.isSyncing = true
            self.syncStatus = "Đang đồng bộ..."
        }
        
        queue.async { [weak self] in
            guard let self = self else { return }
            
            // Simulate sync process
            Thread.sleep(forTimeInterval: 1.0)
            
            DispatchQueue.main.async {
                self.isSyncing = false
                self.lastSyncDate = Date()
                self.syncStatus = "Đồng bộ thành công"
                print(" Đã đồng bộ dữ liệu với máy chủ")
            }
        }
    }
    
    // MARK: - Start Auto Sync
    func startAutoSync() {
        guard AppConstants.Sync.isAutoSyncEnabled else { return }
        
        syncTimer = Timer.scheduledTimer(withTimeInterval: AppConstants.Sync.interval, repeats: true) { [weak self] _ in
            self?.processQueue()
        }
    }
    
    // MARK: - Stop Auto Sync
    func stopAutoSync() {
        syncTimer?.invalidate()
        syncTimer = nil
    }
    
    // MARK: - Manual Sync
    func manualSync() async {
        processQueue()
        // Chờ cho đến khi hoàn thành
        while isSyncing {
            try? await Task.sleep(nanoseconds: 100_000_000) // 0.1 giây
        }
    }
    
    deinit {
        stopAutoSync()
        monitor.cancel()
    }
}

// MARK: - Sync Action Enum
enum SyncAction: String, Codable {
    case createInvoice = "CREATE_INVOICE"
    case updateInvoice = "UPDATE_INVOICE"
    case deleteInvoice = "DELETE_INVOICE"
    case createClient = "CREATE_CLIENT"
    case updateClient = "UPDATE_CLIENT"
    case deleteClient = "DELETE_CLIENT"
}

// MARK: - Sync Queue Item
struct SyncQueueItem {
    let id: UUID
    let action: SyncAction
    let timestamp: Date
    var retryCount: Int
    let maxRetries: Int
    let data: Any
}
