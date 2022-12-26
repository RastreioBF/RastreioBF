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

extension DataProduct {

    @objc(insertObject:inTrackingHistoryAtIndex:)
    @NSManaged public func insertIntoTrackingHistory(_ value: TrackingStatus, at idx: Int)

    @objc(removeObjectFromTrackingHistoryAtIndex:)
    @NSManaged public func removeFromTrackingHistory(at idx: Int)

    @objc(insertTrackingHistory:atIndexes:)
    @NSManaged public func insertIntoTrackingHistory(_ values: [TrackingStatus], at indexes: NSIndexSet)

    @objc(removeTrackingHistoryAtIndexes:)
    @NSManaged public func removeFromTrackingHistory(at indexes: NSIndexSet)

    @objc(replaceObjectInTrackingHistoryAtIndex:withObject:)
    @NSManaged public func replaceTrackingHistory(at idx: Int, with value: TrackingStatus)

    @objc(replaceTrackingHistoryAtIndexes:withTrackingHistory:)
    @NSManaged public func replaceTrackingHistory(at indexes: NSIndexSet, with values: [TrackingStatus])

    @objc(addTrackingHistoryObject:)
    @NSManaged public func addToTrackingHistory(_ value: TrackingStatus)

    @objc(removeTrackingHistoryObject:)
    @NSManaged public func removeFromTrackingHistory(_ value: TrackingStatus)

    @objc(addTrackingHistory:)
    @NSManaged public func addToTrackingHistory(_ values: NSOrderedSet)

    @objc(removeTrackingHistory:)
    @NSManaged public func removeFromTrackingHistory(_ values: NSOrderedSet)

}

extension DataProduct : Identifiable {

}
