import SwiftUI

struct ContentView: View {
    @State private var selection: String? = "dashboard"
    @StateObject private var syncManager = SyncManager.shared
    
    var body: some View {
        NavigationSplitView {
            SidebarView(selection: $selection)
        } detail: {
            if let selection = selection {
                switch selection {
                case "dashboard":
                    DashboardView()
                case "invoices":
                    InvoiceListView()
                case "clients":
                    ClientListView()
                case "settings":
                    SettingsView()
                default:
                    Text("Chọn một mục từ menu")
                }
            } else {
                Text("Chọn một mục từ menu")
            }
        }
        .onAppear {
            syncManager.startAutoSync()
        }
        .onDisappear {
            syncManager.stopAutoSync()
        }
    }
}

// MARK: - Sidebar View
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
                        Task {
                            await syncManager.manualSync()
                        }
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

// MARK: - Dashboard View
struct DashboardView: View {
    @StateObject private var viewModel = InvoiceListViewModel()
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Dashboard")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.horizontal)
                
                // Statistics Cards
                HStack(spacing: 16) {
                    StatisticCard(
                        title: "Tổng doanh thu",
                        value: formatCurrency(viewModel.totalRevenue),
                        icon: "dollarsign.circle.fill",
                        color: AppConstants.Colors.success
                    )
                    
                    StatisticCard(
                        title: "Chưa thanh toán",
                        value: formatCurrency(viewModel.totalOutstanding),
                        icon: "clock.fill",
                        color: AppConstants.Colors.warning
                    )
                    
                    StatisticCard(
                        title: "Quá hạn",
                        value: String(viewModel.overdueCount),
                        icon: "exclamationmark.circle.fill",
                        color: AppConstants.Colors.danger
                    )
                }
                .padding(.horizontal)
                
                Divider()
                    .padding(.horizontal)
                
                // Recent Invoices
                VStack(alignment: .leading, spacing: 12) {
                    Text("Hóa đơn gần đây")
                        .font(.headline)
                        .padding(.horizontal)
                    
                    if viewModel.filteredInvoices.isEmpty {
                        Text("Không có hóa đơn")
                            .foregroundColor(.gray)
                            .padding(.horizontal)
                    } else {
                        ForEach(viewModel.filteredInvoices.prefix(5), id: \\.id) { invoice in
                            InvoiceRowView(invoice: invoice)
                                .padding(.horizontal)
                        }
                    }
                }
                
                Spacer()
            }
            .padding(.vertical)
        }
    }
    
    private func formatCurrency(_ amount: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = AppConstants.Finance.currencyCode
        return formatter.string(from: NSNumber(value: amount)) ?? "0"
    }
}

// MARK: - Statistic Card
struct StatisticCard: View {
    let title: String
    let value: String
    let icon: String
    let color: Color
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: icon)
                    .font(.title2)
                    .foregroundColor(color)
                
                Spacer()
            }
            
            Text(title)
                .font(.caption)
                .foregroundColor(.gray)
            
            Text(value)
                .font(.title2)
                .fontWeight(.bold)
        }
        .padding()
        .background(AppConstants.Colors.neutral)
        .cornerRadius(8)
    }
}

// MARK: - Invoice Row
struct InvoiceRowView: View {
    let invoice: Invoice
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(invoice.invoiceNumber)
                    .fontWeight(.semibold)
                
                Text(invoice.clientName)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: 4) {
                Text(formatCurrency(invoice.totalAmount))
                    .fontWeight(.semibold)
                
                HStack(spacing: 4) {
                    StatusBadge(status: invoice.status)
                }
            }
        }
        .padding()
        .background(Color(nsColor: .controlBackgroundColor))
        .cornerRadius(6)
    }
    
    private func formatCurrency(_ amount: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = AppConstants.Finance.currencyCode
        return formatter.string(from: NSNumber(value: amount)) ?? "0"
    }
}

// MARK: - Status Badge
struct StatusBadge: View {
    let status: String
    
    var badgeColor: Color {
        switch status {
        case "draft": return Color.gray
        case "pending": return Color.blue
        case "paid": return Color.green
        case "overdue": return Color.red
        default: return Color.gray
        }
    }
    
    var statusText: String {
        switch status {
        case "draft": return "Nháp"
        case "pending": return "Chờ xử lý"
        case "paid": return "Đã trả"
        case "overdue": return "Quá hạn"
        default: return status
        }
    }
    
    var body: some View {
        Text(statusText)
            .font(.caption2)
            .fontWeight(.semibold)
            .foregroundColor(.white)
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(badgeColor)
            .cornerRadius(4)
    }
}

#Preview {
    ContentView()
}
