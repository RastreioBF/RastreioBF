//
//  PendenciesViewModel.swift
//  RastreioBF
//
//  Created by Anderson Sales on 03/12/22.
//

import Foundation

class PendenciesViewControllerViewModel {
    
    private static var data : [DataProduct] = [ DataProduct(
        productName: "Nome do Produto",
        productNameImage: "errorImage",
        codeTraking: "AA123456789BR",
        productDescription: "Status da Entrega",
        data: "DD/MM/AAAA",
        time: "HH:MM",
        status: "pending")
    ]
    
    func getLastData() -> DataProduct? {
        return PendenciesViewControllerViewModel.data.last
    }
    
    func setupDataProduct(data: DataProduct) {
        PendenciesViewControllerViewModel.data.append(data)
    }
    
    func getDataProduct(indexPath: IndexPath) -> DataProduct {
        return PendenciesViewControllerViewModel.data[indexPath.row]
    }
    
    var dataArraySize: Int {
        return PendenciesViewControllerViewModel.data.count
    }
    
    func removeData(indexPath: IndexPath) {
        PendenciesViewControllerViewModel.data.remove(at: indexPath.row)
    }
    
    var heightForRowAt: CGFloat {
        return 125
    }
}
