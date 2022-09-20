//
//  String+.swift
//  RastreioBF
//
//  Created by Jessica Bigal on 09/09/22.
//

import Foundation

public extension String {
    enum LocalizedFeatureKind {
        case presentation
        case acessibility
    }
    
    var text: String {
        return localized(.presentation)
    }
    
    func localized(_ feature: LocalizedFeatureKind = .presentation)-> String {
        
        var fileName = String()
        
        switch feature {
        case .presentation:
            fileName = "RastreioBF"
        case .acessibility:
            fileName = "RastreioBF"
        }
        
        return NSLocalizedString(self, tableName: fileName, bundle: .moduleBundle, value: String(), comment: String())
    }
}
