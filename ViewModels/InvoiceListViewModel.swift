import Foundation
import CoreData
import Combine

class InvoiceListViewModel: NSObject, ObservableObject, NSFetchedResultsControllerDelegate {
    @Published var invoices: [Invoice] = []
    @Published var filteredInvoices: [Invoice] = []
    @Published var searchText: String = ""
    @Published var selectedStatus: String? = nil
    @Published var selectedDateRange: (Date, Date)? = nil
    @Published var totalRevenue: Double = 0
    @Published var totalOutstanding: Double = 0
    @Published var overdueCount: Int = 0
    @Published var isLoading = false
    
    private let dataManager = CoreDataManager.shared
    private var fetchedResultsController: NSFetchedResultsController<Invoice>?
    private var cancellables = Set<AnyCancellable>()
    
    override init() {
        super.init()
        setupFetchedResultsController()
        setupFilters()
    }
    
    // MARK: - Setup Fetched Results Controller
    private func setupFetchedResultsController() {
        let fetchRequest = Invoice.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \Invoice.invoiceDate, ascending: false)]
        
        let controller = NSFetchedResultsController(
            fetchRequest: fetchRequest,
            managedObjectContext: dataManager.context,
            sectionNameKeyPath: nil,
            cacheName: nil
        )
        controller.delegate = self
        
        do {
            try controller.performFetch()
            self.fetchedResultsController = controller
            self.invoices = controller.fetchedObjects ?? []
        } catch {
            print("❌ Lỗi fetch invoices: \(error)")
        }
    }
    
    // MARK: - Setup Filters
    private func setupFilters() {
        Publishers.CombineLatest3($searchText, $selectedStatus, $selectedDateRange)
            .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
            .sink { [weak self] searchText, status, dateRange in
                self?.applyFilters(searchText: searchText, status: status, dateRange: dateRange)
            }
            .store(in: &cancellables)
    }
    
    // MARK: - Apply Filters
    private func applyFilters(searchText: String, status: String?, dateRange: (Date, Date)?) {
        var predicate: NSPredicate?
        var predicates: [NSPredicate] = []
        
        // Search by invoice number or client name
        if !searchText.isEmpty {
            let searchPredicate = NSPredicate(format: "invoiceNumber CONTAINS[cd] %@ OR clientName CONTAINS[cd] %@", searchText, searchText)
            predicates.append(searchPredicate)
        }
        
        // Filter by status
        if let status = status {
            let statusPredicate = NSPredicate(format: "status == %@", status)
            predicates.append(statusPredicate)
        }
        
        // Filter by date range
        if let (fromDate, toDate) = dateRange {
            let datePredicate = NSPredicate(format: "invoiceDate >= %@ AND invoiceDate <= %@", fromDate as NSDate, toDate as NSDate)
            predicates.append(datePredicate)
        }
        
        if !predicates.isEmpty {
            predicate = NSCompoundPredicate(andPredicateWithSubpredicates: predicates)
        }
        
        fetchedResultsController?.fetchRequest.predicate = predicate
        
        do {
            try fetchedResultsController?.performFetch()
            self.filteredInvoices = fetchedResultsController?.fetchedObjects ?? []
            calculateStatistics()
        } catch {
            print("❌ Lỗi filter invoices: \(error)")
        }
    }
    
    // MARK: - Calculate Statistics
    func calculateStatistics() {
        totalRevenue = filteredInvoices.reduce(0) { $0 + $1.totalAmount }
        totalOutstanding = filteredInvoices.reduce(0) { $0 + $1.remainingAmount }
        overdueCount = filteredInvoices.filter { $0.isOverdue }.count
    }
    
    // MARK: - Delete Invoice
    func deleteInvoice(_ invoice: Invoice) {
        dataManager.delete(invoice)
        SyncManager.shared.enqueueData(.deleteInvoice, data: ["invoiceId": invoice.id])
    }
    
    // MARK: - Duplicate Invoice
    func duplicateInvoice(_ invoice: Invoice) {
        guard let newInvoice = dataManager.createObject(Invoice.self) else { return }
        
        newInvoice.id = UUID()
        newInvoice.invoiceNumber = "\(invoice.invoiceNumber)-COPY"
        newInvoice.invoiceDate = Date()
        newInvoice.dueDate = Date().addingTimeInterval(2592000)
        newInvoice.status = "draft"
        newInvoice.subtotal = invoice.subtotal
        newInvoice.discountRate = invoice.discountRate
        newInvoice.discountAmount = invoice.discountAmount
        newInvoice.subtotalAfterDiscount = invoice.subtotalAfterDiscount
        newInvoice.vatRate = invoice.vatRate
        newInvoice.vatAmount = invoice.vatAmount
        newInvoice.totalAmount = invoice.totalAmount
        newInvoice.clientId = invoice.clientId
        newInvoice.clientName = invoice.clientName
        newInvoice.clientEmail = invoice.clientEmail
        newInvoice.clientPhone = invoice.clientPhone
        newInvoice.clientAddress = invoice.clientAddress
        newInvoice.paymentMethod = invoice.paymentMethod
        newInvoice.paymentStatus = "unpaid"
        newInvoice.paidAmount = 0
        newInvoice.description_field = invoice.description_field
        newInvoice.notes = invoice.notes
        newInvoice.createdAt = Date()
        newInvoice.updatedAt = Date()
        
        dataManager.save()
    }
    
    // MARK: - Update Payment Status
    func updatePaymentStatus(_ invoice: Invoice, status: String, amount: Double) {
        invoice.paymentStatus = status
        invoice.paidAmount = amount
        if status == "paid" {
            invoice.paymentDate = Date()
        }
        dataManager.save()
    }
    
    // MARK: - Get Display Date
    func getDisplayDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = AppConstants.App.dateFormat
        return formatter.string(from: date)
    }
    
    // MARK: - NSFetchedResultsControllerDelegate
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        DispatchQueue.main.async {
            self.invoices = self.fetchedResultsController?.fetchedObjects ?? []
        }
    }
}
