import CoreData
import Foundation

class CoreDataManager {
    static let shared = CoreDataManager()
    
    let container: NSPersistentContainer
    let context: NSManagedObjectContext
    
    private init() {
        // Tạo Persistent Container
        container = NSPersistentContainer(name: "B2BInvoice")
        
        // Load persistent stores
        container.loadPersistentStores { description, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        
        // Cấu hình context
        container.viewContext.automaticallyMergesChangesFromParent = true
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        context = container.viewContext
    }
    
    // MARK: - Lưu dữ liệu
    func save() {
        let context = container.viewContext
        
        if context.hasChanges {
            do {
                try context.save()
                print(" Dữ liệu đã lưu thành công")
            } catch {
                let nsError = error as NSError
                print(" Lỗi lưu dữ liệu: \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    // MARK: - Xóa dữ liệu
    func delete(_ object: NSManagedObject) {
        container.viewContext.delete(object)
        save()
    }
    
    // MARK: - Tìm kiếm
    func fetchRequest<T: NSManagedObject>(_ entityType: T.Type,
                                         predicate: NSPredicate? = nil,
                                         sortDescriptors: [NSSortDescriptor] = []) -> [T] {
        let request = NSFetchRequest<T>(entityName: String(describing: entityType))
        request.predicate = predicate
        request.sortDescriptors = sortDescriptors
        
        do {
            return try container.viewContext.fetch(request)
        } catch {
            print(" Lỗi tìm kiếm: \(error)")
            return []
        }
    }
    
    // MARK: - Tạo object mới
    func createObject<T: NSManagedObject>(_ entityType: T.Type) -> T? {
        guard let entity = NSEntityDescription.entity(forEntityName: String(describing: entityType),
                                                      in: container.viewContext) else {
            return nil
        }
        
        return T(entity: entity, insertInto: container.viewContext)
    }
    
    // MARK: - Reset (Xóa tất cả dữ liệu)
    func resetAllData() {
        do {
            let context = container.viewContext
            let model = container.managedObjectModel
            
            for entity in model.entities {
                guard let name = entity.name else { continue }
                let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: name)
                let batchDelete = NSBatchDeleteRequest(fetchRequest: fetchRequest)
                batchDelete.resultType = .resultTypeObjectIDs
                
                if let result = try context.execute(batchDelete) as? NSBatchDeleteResult,
                   let objectIDs = result.result as? [NSManagedObjectID], !objectIDs.isEmpty {
                    let changes: [AnyHashable: Any] = [NSDeletedObjectsKey: objectIDs]
                    NSManagedObjectContext.mergeChanges(fromRemoteContextSave: changes, into: [context])
                }
            }
            try context.save()
            print(" Đã reset tất cả dữ liệu")
        } catch {
            print(" Lỗi reset dữ liệu: \(error)")
        }
    }
}
