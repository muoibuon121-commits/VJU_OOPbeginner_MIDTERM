import Foundation
import CoreData

@objc(Invoice)
public class Invoice: NSManagedObject {
    @NSManaged public var id: UUID
    @NSManaged public var invoiceNumber: String
    @NSManaged public var invoiceDate: Date
    @NSManaged public var dueDate: Date
    @NSManaged public var status: String // draft, pending, paid, overdue, cancelled
    
    // Thông tin chi phí
    @NSManaged public var subtotal: Double
    @NSManaged public var discountRate: Double
    @NSManaged public var discountAmount: Double
    @NSManaged public var subtotalAfterDiscount: Double
    @NSManaged public var vatRate: Double
    @NSManaged public var vatAmount: Double
    @NSManaged public var totalAmount: Double
    
    // Thông tin khách hàng
    @NSManaged public var clientId: UUID
    @NSManaged public var clientName: String
    @NSManaged public var clientEmail: String
    @NSManaged public var clientPhone: String
    @NSManaged public var clientAddress: String
    
    // Thông tin thanh toán
    @NSManaged public var paymentMethod: String // bank, cash, cheque, transfer
    @NSManaged public var paymentStatus: String // unpaid, partial, paid
    @NSManaged public var paidAmount: Double
    @NSManaged public var paymentDate: Date?
    
    // Thông tin bổ sung
    @NSManaged public var description_field: String
    @NSManaged public var notes: String
    @NSManaged public var createdAt: Date
    @NSManaged public var updatedAt: Date
    @NSManaged public var lastSyncedAt: Date?
    
    // Computed Properties
    var remainingAmount: Double {
        return totalAmount - paidAmount
    }
    
    var isOverdue: Bool {
        return Date() > dueDate && paymentStatus != "paid"
    }
    
    var daysUntilDue: Int {
        return Calendar.current.dateComponents([.day], from: Date(), to: dueDate).day ?? 0
    }
}

extension Invoice {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Invoice> {
        return NSFetchRequest<Invoice>(entityName: "Invoice")
    }
    
    static func byInvoiceNumber(_ number: String) -> NSFetchRequest<Invoice> {
        let request = fetchRequest()
        request.predicate = NSPredicate(format: "invoiceNumber == %@", number)
        return request
    }
    
    static func byStatus(_ status: String) -> NSFetchRequest<Invoice> {
        let request = fetchRequest()
        request.predicate = NSPredicate(format: "status == %@", status)
        return request
    }
    
    static func byClient(_ clientId: UUID) -> NSFetchRequest<Invoice> {
        let request = fetchRequest()
        request.predicate = NSPredicate(format: "clientId == %@", clientId as CVarArg)
        return request
    }
    
    static func byDateRange(from: Date, to: Date) -> NSFetchRequest<Invoice> {
        let request = fetchRequest()
        request.predicate = NSPredicate(format: "invoiceDate >= %@ AND invoiceDate <= %@", from as NSDate, to as NSDate)
        return request
    }
    
    static func overdue() -> NSFetchRequest<Invoice> {
        let request = fetchRequest()
        request.predicate = NSPredicate(format: "dueDate < %@ AND paymentStatus != 'paid'", Date() as NSDate)
        return request
    }
}

