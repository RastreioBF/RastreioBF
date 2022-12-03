//
//  TrackingViewModel.swift
//  RastreioBF
//
//  Created by Anderson Sales on 03/12/22.
//

import Foundation

struct TrackingViewControllerViewModel {
    
    private static var data : [DataProduct] = [ DataProduct(
        productName: "Nome do Produto",
        productNameImage: "post",
        codeTraking: "AA123456789BR",
        productDescription: "Status da Entrega",
        data: "DD/MM/AAAA",
        time: "HH:MM",
        status: "new"),
    ]
    
    func getStatus(index: Int) -> String? {
        return TrackingViewControllerViewModel.data[index].status
    }
    
    func getLastData() -> DataProduct? {
        return TrackingViewControllerViewModel.data.last
    }
    
    mutating func setupDataProduct(data: DataProduct) {
        TrackingViewControllerViewModel.data.append(data)
    }
    
    func getDataProduct(indexPath: IndexPath) -> DataProduct {
        return TrackingViewControllerViewModel.data[indexPath.row]
    }
    
    var dataArraySize: Int {
        return TrackingViewControllerViewModel.data.count
    }
    
    mutating func removeData(indexPath: IndexPath) {
        TrackingViewControllerViewModel.data.remove(at: indexPath.row)
    }
    
    var heightForRowAt: CGFloat {
        return 125
    }
}
