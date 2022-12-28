//
//  DataProduct+CoreDataProperties.swift
//  RastreioBF
//
//  Created by Anderson Sales on 04/12/22.
//
//

import Foundation
import CoreData

extension DataProduct {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DataProduct> {
        return NSFetchRequest<DataProduct>(entityName: LC.dataProduct.text)
    }

    @NSManaged public var productName: String?
    @NSManaged public var productLocal: String?
    @NSManaged public var codeTraking: String?
    @NSManaged public var productDescription: String?
    @NSManaged public var date: String?
    @NSManaged public var time: String?
    @NSManaged public var status: String?
    @NSManaged public var image: String?
    @NSManaged public var tintColor: String?
}

extension DataProduct : Identifiable {

}
