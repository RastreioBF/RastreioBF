//
//  CoreDataManager.swift
//  RastreioBF
//
//  Created by Jessica Bigal on 17/12/22.
//

import Foundation
import CoreData

struct CoreDataManager {
    
    static let shared = CoreDataManager()
    
    let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "DataProduct")
        
        container.loadPersistentStores { (_, err) in
            if let err = err {
                fatalError("Failed to load persistent store: \(err)")
            }
        }
        return container
    }()
    
    func updateData(codeTracking:String)-> Bool {
        let context = persistentContainer.viewContext
        let request = NSFetchRequest<DataProduct>(entityName: "DataProduct")
        
        request.predicate = NSPredicate(format: "codeTraking == %@", codeTracking)
        
        let result = try? context.fetch(request)
        if (result ?? []).isEmpty {
            return true
        } else {
            return false
        }
    }
    
    
    func fetchPackages() -> [DataProduct] {
        let fetchRequest = NSFetchRequest<DataProduct>(entityName: "DataProduct")
        let context = persistentContainer.viewContext
        
        do {
            let packages = try context.fetch(fetchRequest)
            return packages
        } catch let fetchErr {
            print("Failed to fetch packages: ", fetchErr)
            return []
        }
    }
    
    func deleteAllPackages() {
        let fetchRequest = NSFetchRequest<DataProduct>(entityName: "DataProduct")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest as! NSFetchRequest<NSFetchRequestResult>)
        let context = persistentContainer.viewContext
        
        do {
            try context.execute(deleteRequest)
        } catch let delError {
            print("Failed to delete packages: ", delError)
        }
        
    }
    
    func addPackage(name: String, trackingNumber: String) -> DataProduct {
        let context = persistentContainer.viewContext
        
        let package = DataProduct(context: context)
        package.productDescription = name
        package.codeTraking = trackingNumber
        
        saveContext()
        return package
    }
    
    func updatePackage(package: DataProduct, trackingJson: Package) {
        let api = trackingJson.eventos?.first
        
        trackingJson.eventos?.forEach({ (eventos) in
            let context = persistentContainer.viewContext
            package.status = api?.status ?? ""
            package.time = api?.hora
            package.date = api?.data
            package.productLocal = api?.local
            package.image = ""
            
            let errorImage:Bool = package.status?.contains("pagamento") ?? false ||
            package.status?.contains("análise")  ?? false ||
            package.status?.contains("aduaneira") ?? false ||
            package.status?.contains("faltam") ?? false
            
            let doneImage:Bool = package.status?.contains("entregue") ?? false ||
            package.status?.contains("entrega") ?? false ||
            package.status?.contains("Entrega") ?? false
            
            if  errorImage {
                package.image = "errorImage"
            } else if doneImage {
                package.image = "done"
            } else {
                package.image = "truck"
            }
            print(package)
            saveContext()
        })
    }
    
    private func saveContext() {
        let context = persistentContainer.viewContext
        do {
            try context.save()
        } catch let saveErr {
            fatalError("Failed to save package: \(saveErr)")
        }
    }
    
    private func getDate(date: String) -> Date? {
        var newDateString = date.components(separatedBy: ".")[0]
        newDateString.append("Z")
        
        let dateFormatter = ISO8601DateFormatter()
        return dateFormatter.date(from: newDateString)
    }
    
    var storeContainer: NSPersistentContainer = {

                let container = NSPersistentContainer(name: "DataProduct")
                container.loadPersistentStores { (storeDescription, error) in
//                    self.handle(error)
                }
                return container
    
        }()
    
   var managedContext: NSManagedObjectContext!
    
    public func fetch<T: NSManagedObject>(_ fetchRequest: NSFetchRequest<T>, ofType _: T.Type, async: Bool = true, completion: @escaping (Result<[T], Error>) -> ()) {

        if async {

            let asyncFetchRequest = NSAsynchronousFetchRequest<T>(fetchRequest: fetchRequest) { (result: NSAsynchronousFetchResult) in

                guard let finalResult = result.finalResult else {
                    self.handle(CoreDataStackError.noFinalResult) {
                        completion(.failure(CoreDataStackError.noFinalResult))
                    }
                    return
                }
                completion(.success(finalResult))
            }

            do {
                try managedContext.execute(asyncFetchRequest)
            } catch let error as NSError {
                handle(error) {
                    completion(.failure(error))
                }
            }

        } else {

            do {
                let result = try managedContext.fetch(fetchRequest)
                completion(.success(result))
            } catch let error as NSError {
                handle(error) {
                    completion(.failure(error))
                }
            }

        }
    }

    
    func fetch<T: NSManagedObject>(requestName: String, ofType _: T.Type, async: Bool = true, completion: @escaping (Result<[T], Error>) -> ()) {
        guard let fetchRequest = managedContext.persistentStoreCoordinator?.managedObjectModel.fetchRequestTemplate(forName: requestName) as? NSFetchRequest<T> else {
            self.handle(CoreDataStackError.noFetchRequest) {
                completion(.failure(CoreDataStackError.noFetchRequest))
            }
            return
        }
        fetch(fetchRequest, ofType: T.self, async: async, completion: completion)
    }

    private func handle(_ error: Error?, completion: @escaping () -> () = {}) {
        if let error = error as NSError? {
            let message = "CoreDataStack -> \(#function): Unresolved error: \(error), \(error.userInfo)"
//            if usesFatalError {
//                fatalError(message)
//            } else {
//                print(message)
//            }
            completion()
        }
    }
}

struct CoreDataStackError {
    static let noFetchRequest = NSError(domain: "No Fetch Request", code: 1, userInfo: nil)
    static let noFinalResult = NSError(domain: "No Final Result", code: 1, userInfo: nil)
}
