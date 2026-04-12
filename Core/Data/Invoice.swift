import Foundation
import CoreData

@objc(Invoice)
public class Invoice: NSManagedObject { }

extension Invoice {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Invoice> {
        return NSFetchRequest<Invoice>(entityName: "Invoice")
    }
    
    // MARK: - Core Data Properties
    @NSManaged public var id: UUID
    @NSManaged public var invoiceNumber: String
    @NSManaged public var invoiceDate: Date
    @NSManaged public var dueDate: Date
    @NSManaged public var status: String
    @NSManaged public var subtotal: Double
    @NSManaged public var discountRate: Double
    @NSManaged public var discountAmount: Double
    @NSManaged public var subtotalAfterDiscount: Double
    @NSManaged public var vatRate: Double
    @NSManaged public var vatAmount: Double
    @NSManaged public var totalAmount: Double
    @NSManaged public var clientId: UUID?
    @NSManaged public var clientName: String
    @NSManaged public var clientEmail: String
    @NSManaged public var clientPhone: String
    @NSManaged public var clientAddress: String
    @NSManaged public var paymentMethod: String
    @NSManaged public var paymentStatus: String
    @NSManaged public var paidAmount: Double
    @NSManaged public var description_field: String
    @NSManaged public var notes: String
    @NSManaged public var createdAt: Date
    @NSManaged public var updatedAt: Date
    @NSManaged public var paymentDate: Date?
}

// MARK: - Computed Helpers
extension Invoice {
    public var remainingAmount: Double {
        max(totalAmount - paidAmount, 0)
    }
    
    public var isOverdue: Bool {
        return remainingAmount > 0 && Date() > dueDate && status != "paid"
    }
}

