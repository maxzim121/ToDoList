import UIKit
import CoreData
final class CoreDataOperator {
    static let shared = CoreDataOperator()
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func newBackgroundContext() -> NSManagedObjectContext {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.newBackgroundContext()
        return context
    }
    
    func getAllItems() -> [ToDo] {
        do {
            let items = try context.fetch(ToDo.fetchRequest())
            return items
        }
        catch {
            return []
        }
    }
    
    func createFetchedItem(name: String, status: Bool, context: NSManagedObjectContext) {
        let newItem = ToDo(context: context)
        newItem.id = UUID()
        newItem.name = name
        newItem.status = status
        
        do {
            try context.save()
        } catch {
            // TODO: Добавить обработку ошибки
        }
    }
    
    func createItem() {
        let newItem = ToDo(context: context)
        newItem.id = UUID()
        newItem.name = "Полить цветы"
        
        do {
            try context.save()
        } catch {
            // TODO: Добавить обработку ошибки
        }
    }
    
    func deleteItem(item: ToDo) {
        context.delete(item)
        do {
            try context.save()
        } catch {
            // TODO: Добавить обработку ошибки
        }
    }
    
    func updateItem(item: ToDo) {
        do {
            try context.save()
        } catch {
            // TODO: Добавить обработку ошибки
        }
    }
}
