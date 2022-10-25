//
//  Persistence.swift
//  MediaTracker
//
//  Created by Arthur Roolfs on 10/17/22.
//

import CoreData
import SwiftUI

struct PersistenceController {
    static let shared = PersistenceController()

    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        for _ in 0..<7 {
            let newItem = Food(context: viewContext)
            newItem.ingredient = "as"
            newItem.preparation = "a"
            newItem.type = "Salad"
            newItem.title = "Chicken Soup"
        }
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()

    let container: NSPersistentContainer
    
    @AppStorage("isFirstLaunch") private var isFirstLaunch = true


    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "CookBook")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.

                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
                //fatalError("Unresolve error: \(error)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
        preloadData()
    }
    
    func preloadData() {
        
        if isFirstLaunch == true {
            
            guard let foodURL = Bundle.main.url(forResource: "Recipes", withExtension: "json") else { return }
            guard let contents = try? Data(contentsOf: foodURL) else { return }
            let library = JSON(contents).arrayValue
            isFirstLaunch = false
            
            let bgContext = container.newBackgroundContext()
            bgContext.perform {
                
                do {
                    for item in library {
                        let it = Food(context: bgContext)
                        it.title = item["title"].stringValue
                        it.type = item["category"].stringValue
                        it.ingredient = item["ingredients"].stringValue
                        it.preparation = item["preparation"].stringValue
                    }
                    try bgContext.save()
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }



}
extension Food {
    static var example: Food {
        let ctx = PersistenceController.preview.container.viewContext
        let fetchRequest: NSFetchRequest<Food> = Food.fetchRequest()
        fetchRequest.fetchLimit = 1
        
        let results = try? ctx.fetch(fetchRequest)
        return (results?.first!)!
    }
}

