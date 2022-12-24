//
//  RastreioPackageCellViewModel.swift
//  RastreioBF
//
//  Created by Jessica Bigal on 13/12/22.
//

import Foundation

class PackageCellViewModel {
    
    enum trackingStatus {
        case customs
        case onWay
        case delivered
        case empty
    }
    
    private let service: RastreioBFService = RastreioBFService()
    private var package: Package?
    
    var event: [Eventos] = []
    var test: [Eventos] = []
    
    
    func GetData(code: String) {
        RastreioBFService.sharedObjc.getPackage(packageCode: code) { pack, error in
            if error != nil {
            } else {
                self.event.append(contentsOf: pack!)

            }
        }
    }
    
    var object: Eventos
    
    init(object: Eventos) {
        self.object = object
    }
    
    var date: String {
        return object.data ?? "Error"
    }
    
    var hour: String {
        return object.hora ?? "Error"
    }
    
    var city: String {
        return object.local ?? "Error"
    }
    
    var status: String {
        return object.status ?? "Error"
    }
    
    func imageSelection(evento: Eventos) -> String {
        let status:String = evento.status ?? ""

        if  status == "Devolução autorizada pela Receita Federal" || status.contains("pagamento") || status.contains("análise"){
            return "errorImage"
        } else if status.contains("entregue") || status.contains("entrega"){
            return "done"
        } else {
            return "truck"
        }
    }
}
