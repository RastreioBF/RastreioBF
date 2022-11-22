//
//  WarningViewModel.swift
//  RastreioBF
//
//  Created by Jessica Bigal on 20/11/22.
//

import Foundation

protocol WarningViewModelProtocols: AnyObject {
    func success()
    func failure()
}

class WarningViewModel {
    
    weak var delegate: WarningViewModelProtocols?
    
    var event: [Evento] = []
    var test: [UnidadeEndereco] = []
    
    init(delegate: WarningViewModelProtocols) {
        self.delegate = delegate
    }
    
    func GetData(code: String) {
        RastreioBFService.sharedObjc.getPackage(packageCode: code) { pack, error in
            if error != nil {
                self.delegate?.failure()
            } else {
                self.event.append(contentsOf: pack!)
                self.test.append(self.event[0].unidade.endereco)
                self.delegate?.success()
            }
        }
    }
    
    var count: Int {
        return self.event.count
    }
    
    func GeIndex(indexPath: IndexPath) -> Evento {
        return self.event[indexPath.row]
    }
    
    func getTestIndex(indexPath: IndexPath) -> UnidadeEndereco {
        return self.event[0].unidade.endereco
    }
    
}
