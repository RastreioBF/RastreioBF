//
//  RstreioPackageViewModel.swift
//  RastreioBF
//
//  Created by Jessica Bigal on 13/12/22.
//

import Foundation

class RastreioPackageViewModel {
    
    private let service: RastreioBFService = RastreioBFService()
    private var package: Package?
//    weak var delegate: RastreioPackageViewModelProtocols?
    
    var event: [Eventos] = []
    var test: [Eventos] = []
    
    
    func GetData(code: String) {
        RastreioBFService.sharedObjc.getPackage(packageCode: code) { pack, error in
            if error != nil {
//                self.delegate?.failure()
            } else {
                self.event.append(contentsOf: pack!)
//                self.test.append(self.event[0].status?.text)
//                self.delegate?.success()
            }
        }
    }
    

    
}

