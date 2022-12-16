//
//  RastreioPackageCellViewModel.swift
//  RastreioBF
//
//  Created by Jessica Bigal on 13/12/22.
//

import Foundation

class RastreioPackageCellViewModel {
    
    enum trackingStatus {
        case customs
        case onWay
        case delivered
        case empty
    }
    
    var object: Eventos
    var data: DataEvent
    
    init(object: Eventos, data: DataEvent) {
        self.object = object
        self.data = data
    }
    
    var description: String {
        return data.description ?? "Error"
    }
    
    var code: String {
        return data.code ?? "Error"
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
    
    func imageSelection(model: Eventos) -> String {
        let status:String = object.status ?? ""

        if  status == "Devolução autorizada pela Receita Federal" || status.contains("pagamento") || status.contains("análise"){
            return "errorImage"
        } else if status.contains("entregue") || status.contains("entrega"){
            return "done"
        } else {
            return "truck"
        }
    }
}
