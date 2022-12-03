//
//  PendenciesViewModel.swift
//  RastreioBF
//
//  Created by Anderson Sales on 03/12/22.
//

import Foundation

class PendenciesViewControllerViewModel {
    
    private static var data : [DataProduct] = []
    private static var emptyData: [DataProduct] = [DataProduct(productName: "Sem dados ainda", productNameImage: "avisos", codeTraking: "N/A", productDescription: "Sem descrição", date: "N/A", time: "N/A", status: "Desconhecido")]
    
    func getLastData() -> DataProduct? {
        return PendenciesViewControllerViewModel.data.last
    }
    
    func setupDataProduct(data: DataProduct) {
        PendenciesViewControllerViewModel.data.append(data)
    }
    
    func getDataProduct(indexPath: IndexPath) -> DataProduct {
        if dataArraySize == 0 {
            return PendenciesViewControllerViewModel.emptyData[indexPath.row]
        } else {
            return PendenciesViewControllerViewModel.data[indexPath.row]
        }
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
