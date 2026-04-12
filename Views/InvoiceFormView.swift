import SwiftUI

struct InvoiceFormView: View {
    @StateObject private var viewModel = InvoiceDetailViewModel()
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        Form {
            Section(header: Text("THÔNG TIN HÓA ĐƠN").font(.headline)) {
                TextField("Số hóa đơn", text: $viewModel.invoiceNumber)
                
                DatePicker("Ngày hóa đơn", selection: $viewModel.invoiceDate, displayedComponents: .date)
                
                DatePicker("Ngày đến hạn", selection: $viewModel.dueDate, displayedComponents: .date)
                
                Picker("Trạng thái", selection: $viewModel.status) {
                    Text("Nháp").tag("draft")
                    Text("Chờ xử lý").tag("pending")
                    Text("Đã thanh toán").tag("paid")
                    Text("Quá hạn").tag("overdue")
                }
            }
            
            Section(header: Text("THÔNG TIN KHÁCH HÀNG").font(.headline)) {
                TextField("Tên khách hàng", text: $viewModel.clientName)
                TextField("Email", text: $viewModel.clientEmail)
                    .textContentType(.emailAddress)
                TextField("Điện thoại", text: $viewModel.clientPhone)
                    .textContentType(.telephoneNumber)
                TextField("Địa chỉ", text: $viewModel.clientAddress)
            }
            
            Section(header: Text("TÍNH TOÁN CHI PHÍ").font(.headline)) {
                HStack {
                    Text("Tổng tiền (trước thuế)")
                    Spacer()
                    TextField("0", value: $viewModel.subtotal, format: .number)
                        .textFieldStyle(.roundedBorder)
                        .frame(width: 150)
                    Text(AppConstants.Finance.currencySymbol)
                }
                
                HStack {
                    Text("Chiết khấu")
                    Spacer()
                    TextField("0", value: $viewModel.discountRate, format: .number)
                        .textFieldStyle(.roundedBorder)
                        .frame(width: 150)
                    Text("%")
                }
                
                HStack {
                    Text("Số tiền chiết khấu")
                        .foregroundColor(.gray)
                    Spacer()
                    Text(formatCurrency(viewModel.discountAmount))
                        .fontWeight(.semibold)
                }
                
                HStack {
                    Text("Tổng sau chiết khấu")
                        .foregroundColor(.gray)
                    Spacer()
                    Text(formatCurrency(viewModel.subtotalAfterDiscount))
                        .fontWeight(.semibold)
                }
                
                Picker("Mức VAT", selection: $viewModel.vatRate) {
                    Text("0% VAT").tag(0.0)
                    Text("5% VAT").tag(0.05)
                    Text("8% VAT").tag(0.08)
                    Text("10% VAT").tag(0.1)
                }
                .pickerStyle(.segmented)
                
                HStack {
                    Text("Số tiền VAT")
                        .foregroundColor(.gray)
                    Spacer()
                    Text(formatCurrency(viewModel.vatAmount))
                        .fontWeight(.semibold)
                }
            }
            
            Section {
                HStack {
                    Text("TỔNG THANH TOÁN")
                        .font(.headline)
                        .fontWeight(.bold)
                    Spacer()
                    Text(formatCurrency(viewModel.totalAmount))
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(AppConstants.Colors.primary)
                }
                .padding(.vertical, 8)
            }
            
            Section(header: Text("THÔNG TIN THANH TOÁN").font(.headline)) {
                Picker("Phương thức thanh toán", selection: $viewModel.paymentMethod) {
                    Text("Chuyển khoản").tag("bank")
                    Text("Tiền mặt").tag("cash")
                    Text("Séc").tag("cheque")
                    Text("Khác").tag("other")
                }
            }
            
            Section(header: Text("GHI CHÚ THÊM").font(.headline)) {
                TextField("Mô tả", text: $viewModel.description_field, axis: .vertical)
                    .lineLimit(3...)
                
                TextField("Ghi chú", text: $viewModel.notes, axis: .vertical)
                    .lineLimit(3...)
            }
            
            Section {
                if let errorMessage = viewModel.errorMessage {
                    Label(errorMessage, systemImage: "exclamationmark.circle")
                        .foregroundColor(.red)
                }
                
                if let successMessage = viewModel.successMessage {
                    Label(successMessage, systemImage: "checkmark.circle")
                        .foregroundColor(.green)
                }
                
                HStack(spacing: 12) {
                    Button(action: {
                        dismiss()
                    }) {
                        Text("Hủy")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.bordered)
                    
                    Button(action: {
                        viewModel.saveInvoice()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                            dismiss()
                        }
                    }) {
                        if viewModel.isSaving {
                            ProgressView()
                                .frame(maxWidth: .infinity)
                        } else {
                            Text("Lưu hóa đơn")
                                .frame(maxWidth: .infinity)
                        }
                    }
                    .buttonStyle(.borderedProminent)
                    .disabled(viewModel.isSaving)
                }
            }
        }
        .padding()
        .navigationTitle("Tạo hóa đơn mới")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func formatCurrency(_ amount: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = AppConstants.Finance.currencyCode
        return formatter.string(from: NSNumber(value: amount)) ?? "0"
    }
}

#Preview {
    InvoiceFormView()
}
