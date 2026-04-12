import SwiftUI

@main
struct B2BInvoiceApp: App {
    // Khởi tạo Core Data Manager
    let persistenceController = CoreDataManager.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                // Cung cấp context cho toàn bộ app để Views có thể truy xuất data
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                // Cấu hình kích thước cửa sổ tối thiểu cho Mac
                .frame(minWidth: 1200, minHeight: 800)
        }
        // Cho phép ẩn hiện thanh Sidebar
        .commands {
            SidebarCommands()
        }
    }
}
