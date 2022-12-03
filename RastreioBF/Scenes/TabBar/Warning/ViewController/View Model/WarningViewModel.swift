//
//  DataProductViewModel.swift
//  RastreioBF
//
//  Created by Anderson Sales on 03/12/22.
//

import Foundation

class WarningViewControllerViewModel {
    
    private static var data : [DataProduct] = []
    private static var emptyData: [DataProduct] = [DataProduct(productName: "Sem dados ainda", productNameImage: "avisos", codeTraking: "N/A", productDescription: "Sem descrição", date: "DD/MM/AAAA", time: "HH:MM", status: "Desconhecido")]
    
    func getLastData() -> DataProduct? {
        return WarningViewControllerViewModel.data.last
    }
    
    func setupDataProduct(data: DataProduct) {
        WarningViewControllerViewModel.data.append(data)
    }
    
    func getDataProduct(indexPath: IndexPath) -> DataProduct {
        if dataArraySize == 0 {
            return WarningViewControllerViewModel.emptyData[indexPath.row]
        } else {
            return WarningViewControllerViewModel.data[indexPath.row]
        }
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
