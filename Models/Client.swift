import Foundation
import CoreData

@objc(Client)
public class Client: NSManagedObject {
    @NSManaged public var id: UUID
    @NSManaged public var name: String
    @NSManaged public var email: String
    @NSManaged public var phone: String
    @NSManaged public var address: String
    @NSManaged public var city: String
    @NSManaged public var country: String
    @NSManaged public var taxCode: String
    
    // Thông tin công ty
    @NSManaged public var companyName: String
    @NSManaged public var companyType: String // B2B, B2C, B2G
    @NSManaged public var industry: String
    @NSManaged public var website: String
    
    // Thống kê
    @NSManaged public var totalInvoices: Int64
    @NSManaged public var totalRevenue: Double
    @NSManaged public var outstandingBalance: Double
    
    // Trạng thái
    @NSManaged public var status: String // active, inactive, blacklisted
    @NSManaged public var creditLimit: Double
    @NSManaged public var paymentTerm: Int // Số ngày thanh toán
    
    // Thông tin bổ sung
    @NSManaged public var contactPerson: String
    @NSManaged public var notes: String
    @NSManaged public var createdAt: Date
    @NSManaged public var updatedAt: Date
    @NSManaged public var lastSyncedAt: Date?
    
    // Computed Properties
    var isActive: Bool {
        return status == "active"
    }
    
    var isOvercredit: Bool {
        return outstandingBalance > creditLimit
    }
    
    var displayName: String {
        return companyName.isEmpty ? name : companyName
    }
}

extension Client {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Client> {
        return NSFetchRequest<Client>(entityName: "Client")
    }
    
    static func byName(_ name: String) -> NSFetchRequest<Client> {
        let request = fetchRequest()
        request.predicate = NSPredicate(format: "name CONTAINS[cd] %@ OR companyName CONTAINS[cd] %@", name, name)
        return request
    }
    
    static func byEmail(_ email: String) -> NSFetchRequest<Client> {
        let request = fetchRequest()
        request.predicate = NSPredicate(format: "email == %@", email)
        return request
    }
    
    static func byTaxCode(_ taxCode: String) -> NSFetchRequest<Client> {
        let request = fetchRequest()
        request.predicate = NSPredicate(format: "taxCode == %@", taxCode)
        return request
    }
    
    static func active() -> NSFetchRequest<Client> {
        let request = fetchRequest()
        request.predicate = NSPredicate(format: "status == 'active'")
        return request
    }
    
    static func overcredit() -> NSFetchRequest<Client> {
        let request = fetchRequest()
        request.predicate = NSPredicate(format: "outstandingBalance > creditLimit")
        return request
    }
}
