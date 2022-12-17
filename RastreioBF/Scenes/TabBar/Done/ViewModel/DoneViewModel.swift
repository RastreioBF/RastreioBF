//
//  DoneViewModel.swift
//  RastreioBF
//
//  Created by Anderson Sales on 03/12/22.
//

import Foundation

class DoneViewControllerViewModel {
    
    private static var data: [DataProduct] = []
    private static var dataHeader : [DataTracking] = []
    
    func setupDataProduct(data: DataProduct) {
        DoneViewControllerViewModel.data.append(data)
    }
    
    func getDataProduct(indexPath: IndexPath) -> DataProduct {
        return DoneViewControllerViewModel.data[indexPath.row]
    }
    
//    func getDataProduct(indexPath: IndexPath) -> DataTracking {
//        return DoneViewControllerViewModel.dataHeader[indexPath.row]
//    }
    
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
