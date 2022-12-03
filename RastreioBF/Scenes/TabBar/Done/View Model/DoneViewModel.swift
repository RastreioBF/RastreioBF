//
//  DoneViewModel.swift
//  RastreioBF
//
//  Created by Anderson Sales on 03/12/22.
//

import Foundation

class DoneViewControllerViewModel {
    
    private static var data: [DataProduct] = []
    private static var emptyData: [DataProduct] = [DataProduct(productName: "Sem dados ainda", productNameImage: "avisos", codeTraking: "N/A", productDescription: "Sem descrição", date: "N/A", time: "N/A", status: "Desconhecido")]
    
    func getLastData() -> DataProduct? {
        return DoneViewControllerViewModel.data.last
    }
    
    func setupDataProduct(data: DataProduct) {
        DoneViewControllerViewModel.data.append(data)
    }
    
    func getDataProduct(indexPath: IndexPath) -> DataProduct {
        if dataArraySize == 0 {
            return DoneViewControllerViewModel.emptyData[indexPath.row]
        } else {
            return DoneViewControllerViewModel.data[indexPath.row]
        }
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
