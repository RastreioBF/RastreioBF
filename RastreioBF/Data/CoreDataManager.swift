//
//  CoreDataManager.swift
//  RastreioBF
//
//  Created by Jessica Bigal on 17/12/22.
//

import Foundation
import CoreData

struct CoreDataManager {
//    static let shared = CoreDataManager()
//    
//    let persistentContainer: NSPersistentContainer = {
//        let container = NSPersistentContainer(name: "DataProduct")
//
//        container.loadPersistentStores { (_, err) in
//            if let err = err {
//                fatalError("Failed to load persistent store: \(err)")
//            }
//        }
//        return container
//    }()
//    
//    
//    func fetchPackages() -> [DataProduct] {
//        let fetchRequest = NSFetchRequest<DataProduct>(entityName: "DataProduct")
//        let context = persistentContainer.viewContext
//        
//        do {
//            let packages = try context.fetch(fetchRequest)
//            return packages
//        } catch let fetchErr {
//            print("Failed to fetch packages: ", fetchErr)
//            return []
//        }
//    }
//    
//    func deleteAllPackages() {
//        let fetchRequest = NSFetchRequest<DataProduct>(entityName: "DataProduct")
//        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest as! NSFetchRequest<NSFetchRequestResult>)
//        let context = persistentContainer.viewContext
//        
//        do {
//            try context.execute(deleteRequest)
//        } catch let delError {
//            print("Failed to delete packages: ", delError)
//        }
//        
//    }
//    
//    func addPackage(name: String, trackingNumber: String) -> DataProduct {
//        let context = persistentContainer.viewContext
//        
//        let package = DataProduct(context: context)
//        package.productDescription = name
//        package.codeTraking = trackingNumber
////        package.status = trackingJson?.eventos?.last?.status
////        package.date = trackingJson?.eventos?.last?.data
////        package.time = trackingJson?.eventos?.last?.hora
////        package.productName = trackingJson?.eventos?.last?.local
//        
////        trackingJson?.eventos?.forEach({ (eventos) in
////            let context = persistentContainer.viewContext
////
////            let trackingStatus = Package(context: context)
////            trackingStatus.status = eventos.status
////            trackingStatus.statusDetails = checkpoint.message
////            if let dateString = eventos.hora {
////                trackingStatus. = getDate(date: dateString)
////            })
//        
//        saveContext()
//        return package
//    }
//    
//    func updatePackage(package: DataProduct, trackingJson: Package) {
//        
//        trackingJson.eventos?.forEach({ (eventos) in
//            let context = persistentContainer.viewContext
//            
//    
//        })
//        saveContext()
//    }
//    
//    private func saveContext() {
//        let context = persistentContainer.viewContext
//        do {
//            try context.save()
//        } catch let saveErr {
//            fatalError("Failed to save package: \(saveErr)")
//        }
//    }
//    
//    private func getDate(date: String) -> Date? {
//        var newDateString = date.components(separatedBy: ".")[0]
//        newDateString.append("Z")
//        
//        let dateFormatter = ISO8601DateFormatter()
//        return dateFormatter.date(from: newDateString)
//    }
}
