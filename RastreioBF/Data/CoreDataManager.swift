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
        let container = NSPersistentContainer(name: LC.dataProduct.text)
        
        container.loadPersistentStores { (_, err) in
            if let err = err {
                fatalError("Failed to load persistent store: \(err)")
            }
        }
        return container
    }()
    
    func updateData(codeTracking:String)-> Bool {
        let context = persistentContainer.viewContext
        let request = NSFetchRequest<DataProduct>(entityName: LC.dataProduct.text)
        
        request.predicate = NSPredicate(format: "codeTraking == %@", codeTracking)
        
        let result = try? context.fetch(request)
        if (result ?? []).isEmpty {
            return true
        } else {
            return false
        }
    }
    
    
    func fetchPackages() -> [DataProduct] {
        let fetchRequest = NSFetchRequest<DataProduct>(entityName: LC.dataProduct.text)
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
        let fetchRequest = NSFetchRequest<DataProduct>(entityName: LC.dataProduct.text)
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
            _ = persistentContainer.viewContext
            package.status = api?.status ?? ""
            package.time = api?.hora
            package.date = api?.data
            package.productLocal = api?.local
            package.image = ""
            package.tintColor = ""
            
            let errorImage:Bool = package.status?.contains(LC.payment.text) ?? false ||
            package.status?.contains(LC.analysis.text)  ?? false ||
            package.status?.contains(LC.customs.text) ?? false ||
            package.status?.contains(LC.missing.text) ?? false
            
            let doneImage:Bool = package.status?.contains(LC.delivered.text) ?? false ||
            package.status?.contains(LC.deliveredCaps.text) ?? false ||
            package.status?.contains(LC.toBeDelivered.text) ?? false
            
            if  errorImage {
                package.image = LC.errorImage.text
                package.tintColor = LC.redColor.text
            } else if doneImage {
                package.image = LC.doneImage.text
                package.tintColor = LC.greenColor.text
            } else {
                package.image = LC.onItsWayImage.text
                package.tintColor = LC.orangeColor.text
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
