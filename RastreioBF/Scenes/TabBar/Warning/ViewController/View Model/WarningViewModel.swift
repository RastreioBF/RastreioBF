//
//  DataProductViewModel.swift
//  RastreioBF
//
//  Created by Anderson Sales on 03/12/22.
//

import Foundation

class WarningViewControllerViewModel {
    
    private static var data : [DataProduct] = [ DataProduct(
        productName: "Nome do Produto",
        productNameImage: "pendencias",
        codeTraking: "AA123456789BR",
        productDescription: "Status da Entrega",
        data: "DD/MM/AAAA",
        time: "HH:MM",
        status: "ongoing")
    ]
    
    func getLastData() -> DataProduct? {
        return WarningViewControllerViewModel.data.last
    }
    
    func setupDataProduct(data: DataProduct) {
        WarningViewControllerViewModel.data.append(data)
    }
    
    func getDataProduct(indexPath: IndexPath) -> DataProduct {
        return WarningViewControllerViewModel.data[indexPath.row]
    }
    
    var dataArraySize: Int {
        return WarningViewControllerViewModel.data.count
    }
    
    func removeData(indexPath: IndexPath) {
        WarningViewControllerViewModel.data.remove(at: indexPath.row)
    }
    
    var heightForRowAt: CGFloat {
        return 125
    }
}
