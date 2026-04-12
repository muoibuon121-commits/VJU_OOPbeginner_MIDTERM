import Foundation
import Combine

class InvoiceDetailViewModel: ObservableObject {
    @Published var subtotal: Double = 0.0
    @Published var discountRate: Double = 0.0      // Tính theo %
    @Published var discountAmount: Double = 0.0
    @Published var subtotalAfterDiscount: Double = 0.0
    @Published var vatRate: Double = AppConstants.Finance.defaultVATRate
    @Published var vatAmount: Double = 0.0
    @Published var totalAmount: Double = 0.0
    
    @Published var invoiceNumber: String = ""
    @Published var invoiceDate: Date = Date()
    @Published var dueDate: Date = Date().addingTimeInterval(2592000) // 30 ngày
    @Published var status: String = "draft"
    
    @Published var clientName: String = ""
    @Published var clientEmail: String = ""
    @Published var clientPhone: String = ""
    @Published var clientAddress: String = ""
    
    @Published var paymentMethod: String = "bank"
    @Published var description_field: String = ""
    @Published var notes: String = ""
    
    @Published var errorMessage: String?
    @Published var successMessage: String?
    @Published var isSaving = false
    
    private var cancellables = Set<AnyCancellable>()
    private let dataManager = CoreDataManager.shared
    private let syncManager = SyncManager.shared
    
    var invoice: Invoice?
    
    init() {
        setupBindings()
    }
    
    // MARK: - Setup Bindings
    private func setupBindings() {
        // Lắng nghe sự thay đổi và tính toán lại realtime
        Publishers.CombineLatest3($subtotal, $discountRate, $vatRate)
            .sink { [weak self] subtotal, discount, vat in
                self?.calculateTotals(subtotal: subtotal, discountRate: discount, vatRate: vat)
            }
            .store(in: &cancellables)
    }
    
    // MARK: - Calculate Totals
    private func calculateTotals(subtotal: Double, discountRate: Double, vatRate: Double) {
        // Tính chiết khấu
        let discountAmount = subtotal * (discountRate / 100)
        self.discountAmount = discountAmount
        
        // Tính tổng sau chiết khấu
        let subtotalAfterDiscount = subtotal - discountAmount
        self.subtotalAfterDiscount = subtotalAfterDiscount
        
        // Tính VAT
        let vatAmount = subtotalAfterDiscount * vatRate
        self.vatAmount = vatAmount
        
        // Tính tổng cuối cùng
        let totalAmount = subtotalAfterDiscount + vatAmount
        self.totalAmount = totalAmount
    }
    
    // MARK: - Validation
    func validate() -> Bool {
        errorMessage = nil
        
        guard !invoiceNumber.trimmingCharacters(in: .whitespaces).isEmpty else {
            errorMessage = "Vui lòng nhập số hóa đơn"
            return false
        }
        
        guard !clientName.trimmingCharacters(in: .whitespaces).isEmpty else {
            errorMessage = "Vui lòng nhập tên khách hàng"
            return false
        }
        
        guard subtotal > 0 else {
            errorMessage = "Tổng tiền phải lớn hơn 0"
            return false
        }
        
        guard discountRate >= 0 && discountRate <= 100 else {
            errorMessage = "Chiết khấu phải từ 0 đến 100%"
            return false
        }
        
        guard vatRate >= 0 && vatRate <= 0.3 else {
            errorMessage = "Mức VAT không hợp lệ"
            return false
        }
        
        guard invoiceDate <= dueDate else {
            errorMessage = "Ngày hóa đơn phải trước ngày đến hạn"
            return false
        }
        
        return true
    }
    
    // MARK: - Save Invoice
    func saveInvoice() {
        guard validate() else { return }
        
        isSaving = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            guard let self = self else { return }
            
            if let invoice = self.invoice {
                // Cập nhật hóa đơn hiện có
                self.updateInvoice(invoice)
            } else {
                // Tạo hóa đơn mới
                self.createNewInvoice()
            }
            
            self.isSaving = false
            self.successMessage = "Hóa đơn đã lưu thành công"
            
            // Đẩy vào hàng đợi đồng bộ
            self.syncManager.enqueueData(.createInvoice, data: ["invoiceNumber": self.invoiceNumber])
        }
    }
    
    private func createNewInvoice() {
        guard let invoice = dataManager.createObject(Invoice.self) else { return }
        
        invoice.id = UUID()
        invoice.invoiceNumber = invoiceNumber
        invoice.invoiceDate = invoiceDate
        invoice.dueDate = dueDate
        invoice.status = status
        invoice.subtotal = subtotal
        invoice.discountRate = discountRate
        invoice.discountAmount = discountAmount
        invoice.subtotalAfterDiscount = subtotalAfterDiscount
        invoice.vatRate = vatRate
        invoice.vatAmount = vatAmount
        invoice.totalAmount = totalAmount
        invoice.clientName = clientName
        invoice.clientEmail = clientEmail
        invoice.clientPhone = clientPhone
        invoice.clientAddress = clientAddress
        invoice.paymentMethod = paymentMethod
        invoice.paymentStatus = "unpaid"
        invoice.paidAmount = 0
        invoice.description_field = description_field
        invoice.notes = notes
        invoice.createdAt = Date()
        invoice.updatedAt = Date()
        
        dataManager.save()
    }
    
    private func updateInvoice(_ invoice: Invoice) {
        invoice.invoiceNumber = invoiceNumber
        invoice.invoiceDate = invoiceDate
        invoice.dueDate = dueDate
        invoice.status = status
        invoice.subtotal = subtotal
        invoice.discountRate = discountRate
        invoice.discountAmount = discountAmount
        invoice.subtotalAfterDiscount = subtotalAfterDiscount
        invoice.vatRate = vatRate
        invoice.vatAmount = vatAmount
        invoice.totalAmount = totalAmount
        invoice.clientName = clientName
        invoice.clientEmail = clientEmail
        invoice.clientPhone = clientPhone
        invoice.clientAddress = clientAddress
        invoice.paymentMethod = paymentMethod
        invoice.description_field = description_field
        invoice.notes = notes
        invoice.updatedAt = Date()
        
        dataManager.save()
    }
    
    // MARK: - Load Invoice
    func loadInvoice(_ invoice: Invoice) {
        self.invoice = invoice
        invoiceNumber = invoice.invoiceNumber
        invoiceDate = invoice.invoiceDate
        dueDate = invoice.dueDate
        status = invoice.status
        subtotal = invoice.subtotal
        discountRate = invoice.discountRate
        vatRate = invoice.vatRate
        clientName = invoice.clientName
        clientEmail = invoice.clientEmail
        clientPhone = invoice.clientPhone
        clientAddress = invoice.clientAddress
        paymentMethod = invoice.paymentMethod
        description_field = invoice.description_field
        notes = invoice.notes
    }
    
    // MARK: - Clear Form
    func clearForm() {
        invoice = nil
        subtotal = 0
        discountRate = 0
        vatRate = AppConstants.Finance.defaultVATRate
        invoiceNumber = ""
        invoiceDate = Date()
        dueDate = Date().addingTimeInterval(2592000)
        status = "draft"
        clientName = ""
        clientEmail = ""
        clientPhone = ""
        clientAddress = ""
        paymentMethod = "bank"
        description_field = ""
        notes = ""
        errorMessage = nil
        successMessage = nil
    }
}
