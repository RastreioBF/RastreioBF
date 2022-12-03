//
//  DoneViewModel.swift
//  RastreioBF
//
//  Created by Anderson Sales on 03/12/22.
//

import Foundation

class DoneViewControllerViewModel {
    
    private static var data : [DataProduct] = [ DataProduct(
        productName: "Nome do Produto",
        productNameImage: "done",
        codeTraking: "AA123456789BR",
        productDescription: "Status da Entrega",
        data: "DD/MM/AAAA",
        time: "HH:MM",
        status: "done"),
    ]
    
    func getLastData() -> DataProduct? {
        return DoneViewControllerViewModel.data.last
    }
    
    func setupDataProduct(data: DataProduct) {
        DoneViewControllerViewModel.data.append(data)
    }
    
    func getDataProduct(indexPath: IndexPath) -> DataProduct {
        return DoneViewControllerViewModel.data[indexPath.row]
    }
    
    var dataArraySize: Int {
        return DoneViewControllerViewModel.data.count
    }
    
    func removeData(indexPath: IndexPath) {
        DoneViewControllerViewModel.data.remove(at: indexPath.row)
    }
    
    var heightForRowAt: CGFloat {
        return 125
    }
}
