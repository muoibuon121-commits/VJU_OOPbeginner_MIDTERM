import Foundation
import SwiftUI

struct AppConstants {
    // Thông tin doanh nghiệp
    static let companyName = "B2B Invoice Management System"
    static let appVersion = "1.0.0"
    static let appBuild = "001"
    
    // Cài đặt giao diện
    struct Colors {
        static let primary = Color(red: 0.122, green: 0.306, blue: 0.471)      // #1F4E78
        static let accent = Color(red: 0.753, green: 0.0, blue: 0.0)           // #C00000
        static let success = Color(red: 0.2, green: 0.8, blue: 0.2)
        static let warning = Color(red: 1.0, green: 0.8, blue: 0.0)
        static let danger = Color(red: 1.0, green: 0.2, blue: 0.2)
        static let neutral = Color(red: 0.96, green: 0.96, blue: 0.96)         // #F5F5F5
        static let text = Color.black
        static let lightText = Color.gray
    }
    
    // Cài đặt API
    struct API {
        static let baseURL = "http://b2b-server.local/api"
        static let timeout: TimeInterval = 30.0
        static let retryCount = 3
        static let retryDelay: TimeInterval = 2.0
    }
    
    // Cài đặt tài chính mặc định
    struct Finance {
        static let defaultVATRate = 0.1          // 10%
        static let defaultDiscountRate = 0.0     // 0%
        static let minInvoiceAmount = 0.0
        static let maxInvoiceAmount = 999_999_999.0
        static let currencyCode = "VND"
        static let currencySymbol = "₫"
    }
    
    // Cài đặt đồng bộ
    struct Sync {
        static let interval: TimeInterval = 300  // 5 phút
        static let maxRetries = 3
        static let isAutoSyncEnabled = true
    }
    
    // Cài đặt ứng dụng
    struct App {
        static let defaultPageSize = 20
        static let maxPageSize = 100
        static let defaultSearchDebounce: TimeInterval = 0.5
        static let dateFormat = "dd/MM/yyyy"
        static let dateTimeFormat = "dd/MM/yyyy HH:mm:ss"
    }
}
