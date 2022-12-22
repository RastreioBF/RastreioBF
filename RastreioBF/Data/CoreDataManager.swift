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
            package.status?.contains("entrega") ?? false
            
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
                                      }
