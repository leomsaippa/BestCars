//
//  DataController.swift
//  BestCars
//
//  Created by Leonardo Saippa on 24/04/21.
//


import Foundation
import CoreData

class DataController {
    
    let persistentContainer:NSPersistentContainer
    
    var viewContext:NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    init(modelName:String) {
        persistentContainer = NSPersistentContainer(name: modelName)
    }
    
    func configureContexts() {
        viewContext.automaticallyMergesChangesFromParent = true
        viewContext.mergePolicy = NSMergePolicy.mergeByPropertyStoreTrump
    }
    
    func load(completion: (() -> Void)? = nil) {
        print("load")
        persistentContainer.loadPersistentStores { storeDescription, error in
            guard error == nil else {
                fatalError(error!.localizedDescription)
            }
          //  self.autoSaveCurrentContext()
            self.configureContexts()
            completion?()
        }
    }
    
    
    func save() throws {
        if viewContext.hasChanges {
     //       try viewContext.save()
        }
    }
    
    static let shared = DataController(modelName: "BestCars")
    
}

extension DataController {
//    func autoSaveCurrentContext(interval:TimeInterval = 30) {
//        print("Saving current context")
//        guard interval > 0 else {
//            print("Interval < 0")
//            return
//        }
//        
//        if viewContext.hasChanges {
//           // try? viewContext.save()
//        }
//        
//        DispatchQueue.main.asyncAfter(deadline: .now() + interval) {
//            self.autoSaveCurrentContext(interval: interval)
//        }
//    }
    
    
    
    func fetchAllCars() throws -> [Car]? {
        let fr = NSFetchRequest<NSFetchRequestResult>(entityName: "Car")
        guard let car = try viewContext.fetch(fr) as? [Car] else {
            return nil
        }
        return car
    }
    
    func fetchCar(_ predicate: NSPredicate, sorting: NSSortDescriptor? = nil) throws -> Car? {
        let fr = NSFetchRequest<NSFetchRequestResult>(entityName: "Car")
        fr.predicate = predicate
        if let sorting = sorting {
            fr.sortDescriptors = [sorting]
        }
        guard let location = (try viewContext.fetch(fr) as! [Car]).first else {
            return nil
        }
        return location
    }
}
