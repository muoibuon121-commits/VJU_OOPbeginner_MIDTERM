import SwiftUI

struct SidebarView: View {
    @Binding var selection: String?
    @StateObject private var syncManager = SyncManager.shared
    
    var body: some View {
        List(selection: $selection) {
            NavigationLink(value: "dashboard") {
                Label("Dashboard", systemImage: "chart.bar.fill")
            }
            
            NavigationLink(value: "invoices") {
                Label("Hóa đơn", systemImage: "doc.text.fill")
            }
            
            NavigationLink(value: "clients") {
                Label("Khách hàng", systemImage: "person.2.fill")
            }
            
            Divider()
            
            NavigationLink(value: "settings") {
                Label("Cài đặt", systemImage: "gear")
            }
        }
        .listStyle(.sidebar)
        .safeAreaInset(edge: .bottom) {
            VStack(alignment: .leading, spacing: 8) {
                Divider()
                
                HStack(spacing: 8) {
                    if syncManager.isSyncing {
                        ProgressView()
                            .scaleEffect(0.7, anchor: .center)
                    } else {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(.green)
                    }
                    
                    VStack(alignment: .leading, spacing: 2) {
                        Text(syncManager.syncStatus)
                            .font(.caption)
                            .fontWeight(.semibold)
                        
                        if let lastSync = syncManager.lastSyncDate {
                            Text("Cập nhật: \(lastSync.formatted(date: .abbreviated, time: .shortened))")
                                .font(.caption2)
                                .foregroundColor(.gray)
                        }
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        Task { await syncManager.manualSync() }
                    }) {
                        Image(systemName: "arrow.clockwise")
                            .font(.caption)
                    }
                    .buttonStyle(.borderless)
                }
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
            }
            .background(AppConstants.Colors.neutral)
        }
        .navigationTitle("B2B Invoice Manager")
    }
}
#Preview {
    @Previewable @State var selection: String? = "dashboard"
    return NavigationSplitView {
        SidebarView(selection: $selection)
    } detail: {
        Text("Chọn một mục từ menu")
    }
}

