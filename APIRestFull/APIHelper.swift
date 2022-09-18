//
//  APIHelper.swift
//  RastreioBF
//
//  Created by Jessica Bigal on 15/09/22.
//

import Foundation

class APIHelper {
    static func rejectNil(_ source: [String:Any?]) -> [String:Any]? {
        var destination = [String:Any]()
        for (key, nillableValue) in source {
            if let value: Any = nillableValue {
                destination[key] = value
            }
        }

        if destination.isEmpty {
            return nil
        }
        return destination
    }

    static func convertBoolToString(_ source: [String: Any]?) -> [String:Any]? {
        guard let source = source else {
            return nil
        }
        var destination = [String:Any]()
        let theTrue = NSNumber(value: true as Bool)
        let theFalse = NSNumber(value: false as Bool)
        for (key, value) in source {
            switch value {
            case let x where x as? NSNumber === theTrue || x as? NSNumber === theFalse:
                destination[key] = "\(value as! Bool)" as Any?
            default:
                destination[key] = value
            }
        }
        return destination
    }

}
