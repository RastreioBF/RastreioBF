//
//  PendenciesViewModel.swift
//  RastreioBF
//
//  Created by Anderson Sales on 03/12/22.
//

import Foundation

class PendenciesViewControllerViewModel {
    
    private static var data : [DataProduct] = []
    private static var dataHeader : [DataTracking] = []
    
    func setupDataProduct(data: DataProduct) {
        PendenciesViewControllerViewModel.data.append(data)
    }
    
    func getDataProduct(indexPath: IndexPath) -> DataProduct {
        return PendenciesViewControllerViewModel.data[indexPath.row]
    }
//
//    func getDataProduct(indexPath: IndexPath) -> DataTracking {
//        return PendenciesViewControllerViewModel.dataHeader[indexPath.row]
//    }
//    
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
