//
//  DataProduct+CoreDataClass.swift
//  RastreioBF
//
//  Created by Anderson Sales on 04/12/22.
//
//

import Foundation
import CoreData

//@objc(DataProduct)
public class DataProduct: NSManagedObject {
    
    public static var entityName: String {
            let className = NSStringFromClass(self)
            let entityName = className.components(separatedBy: ".").last!
            return entityName
        }

        public static var entityClassName: String {
            let className = NSStringFromClass(self)
            return className
        }
}
