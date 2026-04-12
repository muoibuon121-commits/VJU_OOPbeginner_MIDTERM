import SwiftUI

struct ClientListView: View {
    @State private var showingNewClientSheet = false
    @State private var searchText = ""
    @State private var clients: [Client] = []
    
    var body: some View {
        VStack {
            HStack {
                Text("Quản lý khách hàng")
                    .font(.title)
                    .fontWeight(.bold)
                
                Spacer()
                
                Button(action: { showingNewClientSheet = true }) {
                    Label("Thêm khách hàng", systemImage: "plus.circle.fill")
                }
                .buttonStyle(.borderedProminent)
            }
            .padding()
            
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                
                TextField("Tìm kiếm khách hàng...", text: $searchText)
                    .textFieldStyle(.roundedBorder)
            }
            .padding(.horizontal)
            
            if clients.isEmpty {
                VStack {
                    Image(systemName: "person.2.fill")
                        .font(.system(size: 48))
                        .foregroundColor(.gray)
                    
                    Text("Không có khách hàng")
                        .font(.headline)
                    
                    Text("Thêm khách hàng mới để bắt đầu")
                        .foregroundColor(.gray)
                }
                .frame(maxHeight: .infinity)
            } else {
                List {
                    ForEach(clients, id: \\.id) { client in
                        NavigationLink(destination: ClientDetailView(client: client)) {
                            ClientListItemView(client: client)
                        }
                    }
                }
            }
        }
        .sheet(isPresented: $showingNewClientSheet) {
            ClientFormView()
        }
    }
}

// MARK: - Client List Item
struct ClientListItemView: View {
    let client: Client
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(client.displayName)
                        .font(.headline)
                        .fontWeight(.bold)
                    
                    HStack(spacing: 8) {
                        Text(client.email)
                            .font(.caption)
                            .foregroundColor(.blue)
                        
                        Text(client.phone)
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                }
                
                Spacer()
                
                VStack(alignment: .trailing, spacing: 4) {
                    if client.isActive {
                        Label("Hoạt động", systemImage: "checkmark.circle.fill")
                            .font(.caption2)
                            .foregroundColor(.green)
                    } else {
                        Label("Không hoạt động", systemImage: "xmark.circle.fill")
                            .font(.caption2)
                            .foregroundColor(.gray)
                    }
                    
                    Text("Nợ: \(formatCurrency(client.outstandingBalance))")
                        .font(.caption)
                        .foregroundColor(client.isOvercredit ? .red : .blue)
                }
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

// MARK: - Client Detail View
struct ClientDetailView: View {
    let client: Client
    @State private var showingEditSheet = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(client.displayName)
                            .font(.title)
                            .fontWeight(.bold)
                        
                        Text(client.companyType)
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    
                    Spacer()
                    
                    if client.isActive {
                        Text("Hoạt động")
                            .font(.caption)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(Color.green)
                            .cornerRadius(4)
                    }
                }
                
                Divider()
                
                // Contact Info
                VStack(alignment: .leading, spacing: 8) {
                    Text("Thông tin liên hệ")
                        .font(.headline)
                    
                    DetailRow(label: "Email", value: client.email)
                    DetailRow(label: "Điện thoại", value: client.phone)
                    DetailRow(label: "Địa chỉ", value: client.address)
                    DetailRow(label: "Thành phố", value: client.city)
                }
                
                Divider()
                
                // Financial Info
                VStack(alignment: .leading, spacing: 8) {
                    Text("Thông tin tài chính")
                        .font(.headline)
                    
                    DetailRow(label: "Tổng doanh thu", value: formatCurrency(client.totalRevenue))
                    DetailRow(label: "Số hoá đơn", value: String(client.totalInvoices))
                    DetailRow(label: "Nợ hiện tại", value: formatCurrency(client.outstandingBalance),
                              valueColor: client.isOvercredit ? .red : .blue)
                    DetailRow(label: "Hạn mức tín dụng", value: formatCurrency(client.creditLimit))
                }
                
                Spacer()
                
                HStack(spacing: 12) {
                    Button(action: { showingEditSheet = true }) {
                        Label("Chỉnh sửa", systemImage: "pencil")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.bordered)
                    
                    Button(action: { /* View invoices */ }) {
                        Label("Xem hóa đơn", systemImage: "doc.fill")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.borderless)
                }
            }
            .padding()
        }
        .navigationTitle("Chi tiết khách hàng")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func formatCurrency(_ amount: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = AppConstants.Finance.currencyCode
        return formatter.string(from: NSNumber(value: amount)) ?? "0"
    }
}

// MARK: - Client Form View
struct ClientFormView: View {
    @Environment(\\.dismiss) var dismiss
    @State private var name = ""
    @State private var email = ""
    @State private var phone = ""
    @State private var companyName = ""
    @State private var taxCode = ""
    @State private var address = ""
    @State private var city = ""
    
    var body: some View {
        Form {
            Section(header: Text("THÔNG TIN CÁ NHÂN")) {
                TextField("Tên liên hệ", text: $name)
                TextField("Email", text: $email)
                    .textContentType(.emailAddress)
                TextField("Điện thoại", text: $phone)
                    .textContentType(.telephoneNumber)
            }
            
            Section(header: Text("THÔNG TIN CÔNG TY")) {
                TextField("Tên công ty", text: $companyName)
                TextField("Mã số thuế", text: $taxCode)
                TextField("Địa chỉ", text: $address)
                TextField("Thành phố", text: $city)
            }
            
            Section {
                HStack(spacing: 12) {
                    Button(action: { dismiss() }) {
                        Text("Hủy")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.bordered)
                    
                    Button(action: { dismiss() }) {
                        Text("Lưu khách hàng")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)
                }
            }
        }
        .padding()
        .navigationTitle("Thêm khách hàng mới")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    ClientListView()
}
