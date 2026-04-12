import SwiftUI

struct InvoiceListView: View {
    @StateObject private var viewModel = InvoiceListViewModel()
    @State private var showingNewInvoiceSheet = false
    @State private var searchText = ""
    @State private var selectedStatus: String?
    
    var body: some View {
        VStack {
            // Header
            HStack {
                Text("Quản lý hóa đơn")
                    .font(.title)
                    .fontWeight(.bold)
                
                Spacer()
                
                Button(action: { showingNewInvoiceSheet = true }) {
                    Label("Tạo mới", systemImage: "plus.circle.fill")
                }
                .buttonStyle(.borderedProminent)
            }
            .padding()
            
            // Filter Bar
            HStack(spacing: 12) {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                
                TextField("Tìm kiếm hóa đơn...", text: $searchText)
                    .textFieldStyle(.roundedBorder)
                    .onChange(of: searchText) { oldValue, newValue in
                        viewModel.searchText = newValue
                    }
                
                Picker("Trạng thái", selection: $selectedStatus) {
                    Text("Tất cả").tag(Optional<String>(nil))
                    Text("Nháp").tag(Optional("draft"))
                    Text("Chờ xử lý").tag(Optional("pending"))
                    Text("Đã thanh toán").tag(Optional("paid"))
                }
                .onChange(of: selectedStatus) { oldValue, newValue in
                    viewModel.selectedStatus = newValue
                }
            }
            .padding(.horizontal)
            
            // Statistics
            HStack(spacing: 16) {
                StatCard(
                    title: "Tổng doanh thu",
                    value: formatCurrency(viewModel.totalRevenue),
                    color: .green
                )
                
                StatCard(
                    title: "Chưa thanh toán",
                    value: formatCurrency(viewModel.totalOutstanding),
                    color: .orange
                )
                
                StatCard(
                    title: "Quá hạn",
                    value: String(viewModel.overdueCount),
                    color: .red
                )
            }
            .padding(.horizontal)
            
            Divider()
            
            // Invoice List
            if viewModel.filteredInvoices.isEmpty {
                VStack {
                    Image(systemName: "doc.text.fill")
                        .font(.system(size: 48))
                        .foregroundColor(.gray)
                    
                    Text("Không có hóa đơn")
                        .font(.headline)
                    
                    Text("Tạo hóa đơn mới để bắt đầu")
                        .foregroundColor(.gray)
                }
                .frame(maxHeight: .infinity)
            } else {
                List {
                    ForEach(viewModel.filteredInvoices, id: \\.id) { invoice in
                        NavigationLink(destination: InvoiceDetailView(invoice: invoice, viewModel: viewModel)) {
                            InvoiceListItemView(invoice: invoice)
                        }
                        .contextMenu {
                            Button(role: .destructive) {
                                viewModel.deleteInvoice(invoice)
                            } label: {
                                Label("Xóa", systemImage: "trash")
                            }
                            
                            Button {
                                viewModel.duplicateInvoice(invoice)
                            } label: {
                                Label("Sao chép", systemImage: "doc.on.doc")
                            }
                        }
                    }
                }
                .listStyle(.plain)
            }
        }
        .sheet(isPresented: $showingNewInvoiceSheet) {
            NavigationStack {
                InvoiceFormView()
            }
        }
    }
    
    private func formatCurrency(_ amount: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = AppConstants.Finance.currencyCode
        return formatter.string(from: NSNumber(value: amount)) ?? "0"
    }
}

// MARK: - Invoice List Item
struct InvoiceListItemView: View {
    let invoice: Invoice
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(invoice.invoiceNumber)
                        .font(.headline)
                        .fontWeight(.bold)
                    
                    Text(invoice.clientName)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                
                Spacer()
                
                VStack(alignment: .trailing, spacing: 4) {
                    Text(formatCurrency(invoice.totalAmount))
                        .font(.headline)
                        .fontWeight(.bold)
                    
                    Text(invoice.invoiceDate.formatted(date: .abbreviated, time: .omitted))
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            }
            
            HStack {
                StatusBadge(status: invoice.status)
                
                if invoice.isOverdue {
                    Label("Quá hạn", systemImage: "exclamationmark.circle")
                        .font(.caption2)
                        .foregroundColor(.red)
                }
                
                Spacer()
                
                Text("Còn \(formatCurrency(invoice.remainingAmount))")
                    .font(.caption)
                    .foregroundColor(.blue)
            }
        }
        .padding(.vertical, 4)
    }
    
    private func formatCurrency(_ amount: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = AppConstants.Finance.currencyCode
        return formatter.string(from: NSNumber(value: amount)) ?? "0"
    }
}

// MARK: - Invoice Detail View
struct InvoiceDetailView: View {
    let invoice: Invoice
    let viewModel: InvoiceListViewModel
    @State private var showingEditSheet = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // Header
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(invoice.invoiceNumber)
                            .font(.title)
                            .fontWeight(.bold)
                        
                        Text(invoice.clientName)
                            .foregroundColor(.gray)
                    }
                    
                    Spacer()
                    
                    StatusBadge(status: invoice.status)
                }
                
                Divider()
                
                // Client Info
                VStack(alignment: .leading, spacing: 8) {
                    Text("Thông tin khách hàng")
                        .font(.headline)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text(invoice.clientName)
                        Text(invoice.clientEmail)
                            .foregroundColor(.blue)
                        Text(invoice.clientPhone)
                    }
                    .font(.caption)
                }
                
                Divider()
                
                // Invoice Details
                VStack(alignment: .leading, spacing: 8) {
                    Text("Chi tiết hóa đơn")
                        .font(.headline)
                    
                    DetailRow(label: "Ngày hóa đơn", value: invoice.invoiceDate.formatted(date: .abbreviated, time: .omitted))
                    DetailRow(label: "Ngày đến hạn", value: invoice.dueDate.formatted(date: .abbreviated, time: .omitted))
                    DetailRow(label: "Phương thức thanh toán", value: invoice.paymentMethod)
                }
                
                Divider()
                
                // Amounts
                VStack(spacing: 8) {
                    DetailRow(label: "Tổng tiền", value: formatCurrency(invoice.subtotal))
                    DetailRow(label: "Chiết khấu", value: "-\(formatCurrency(invoice.discountAmount))")
                    DetailRow(label: "VAT (\(Int(invoice.vatRate * 100))%)", value: formatCurrency(invoice.vatAmount))
                    
                    Divider()
                    
                    DetailRow(label: "TỔNG THANH TOÁN", value: formatCurrency(invoice.totalAmount), isBold: true)
                    
                    Divider()
                    
                    DetailRow(label: "Đã thanh toán", value: formatCurrency(invoice.paidAmount))
                    DetailRow(label: "Còn lại", value: formatCurrency(invoice.remainingAmount), valueColor: .blue)
                }
                
                Spacer()
                
                // Action Buttons
                HStack(spacing: 12) {
                    Button(action: { showingEditSheet = true }) {
                        Label("Chỉnh sửa", systemImage: "pencil")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.bordered)
                    
                    Button(action: { /* Export PDF */ }) {
                        Label("Xuất PDF", systemImage: "doc.fill")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.borderless)
                }
            }
            .padding()
        }
        .navigationTitle("Chi tiết hóa đơn")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func formatCurrency(_ amount: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = AppConstants.Finance.currencyCode
        return formatter.string(from: NSNumber(value: amount)) ?? "0"
    }
}

// MARK: - Detail Row
struct DetailRow: View {
    let label: String
    let value: String
    var isBold: Bool = false
    var valueColor: Color = .black
    
    var body: some View {
        HStack {
            Text(label)
                .fontWeight(isBold ? .bold : .regular)
            
            Spacer()
            
            Text(value)
                .fontWeight(isBold ? .bold : .regular)
                .foregroundColor(valueColor)
        }
        .font(.caption)
    }
}

// MARK: - Stat Card
struct StatCard: View {
    let title: String
    let value: String
    let color: Color
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.caption)
                .foregroundColor(.gray)
            
            Text(value)
                .font(.headline)
                .fontWeight(.bold)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(color.opacity(0.1))
        .cornerRadius(8)
    }
}

#Preview {
    InvoiceListView()
}
