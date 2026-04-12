import Foundation
import Combine

final class SettingsViewModel: ObservableObject {
    @Published var isAutoSyncEnabled: Bool
    @Published var syncInterval: TimeInterval
    @Published var defaultVATRate: Double
    @Published var defaultDiscountRate: Double
    
    init(
        isAutoSyncEnabled: Bool = AppConstants.Sync.isAutoSyncEnabled,
        syncInterval: TimeInterval = AppConstants.Sync.interval,
        defaultVATRate: Double = AppConstants.Finance.defaultVATRate,
        defaultDiscountRate: Double = AppConstants.Finance.defaultDiscountRate
    ) {
        self.isAutoSyncEnabled = isAutoSyncEnabled
        self.syncInterval = syncInterval
        self.defaultVATRate = defaultVATRate
        self.defaultDiscountRate = defaultDiscountRate
    }
    
    func applyChanges() {
        // Ở đây có thể lưu vào UserDefaults hoặc cấu hình hệ thống
        // Hiện tại chỉ log lại để xác nhận
        print("Cập nhật cài đặt:")
        print("- Auto Sync: \(isAutoSyncEnabled)")
        print("- Interval: \(syncInterval)s")
        print("- VAT: \(defaultVATRate)")
        print("- Discount: \(defaultDiscountRate)")
    }
}
