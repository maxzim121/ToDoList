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
    
    func createItem(name: String, description: String, date: Date, priority: String) {
        let newItem = ToDo(context: context)
        newItem.id = UUID()
        newItem.name = name
        newItem.status = false
        newItem.descriptioin = description
        newItem.date = date
        newItem.priority = priority
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
    
    func completeToDo(item: ToDo) {
        do {
            item.status = true
            try context.save()
        } catch {
            // TODO: Добавить обработку ошибки
        }
    }
}
