//
//  TrackingViewModel.swift
//  RastreioBF
//
//  Created by Anderson Sales on 03/12/22.
//

import Foundation

struct TrackingViewControllerViewModel {
    
    var warningDataVM = WarningViewControllerViewModel()
    var doneDataVM = DoneViewControllerViewModel()
    var pendingDataVM  = PendenciesViewControllerViewModel()
    
    private static var data : [DataProduct] = []
    
    func populateCorrectArray(data: DataProduct?){
        if data!.status.lowercased() == "entregue" {
            doneDataVM.setupDataProduct(data: DataProduct(
                productName: data?.productName ?? "",
                productNameImage: "done",
                codeTraking: data?.codeTraking ?? "",
                productDescription: data?.productDescription ?? "",
                data: data?.data ?? "DD/MM/AAAA",
                time: data?.time ?? "HH:MM",
                status: data?.status ?? "pending"))
            warningDataVM.setupDataProduct(data: data!)
        } else if data!.status.lowercased() == "pendente" {
            pendingDataVM.setupDataProduct(data: DataProduct(
                productName: data?.productName ?? "",
                productNameImage: "errorImage",
                codeTraking: data?.codeTraking ?? "",
                productDescription: data?.productDescription ?? "",
                data: data?.data ?? "DD/MM/AAAA",
                time: data?.time ?? "HH:MM",
                status: data?.status ?? "pending"))
            warningDataVM.setupDataProduct(data: data!)
        } else {
            warningDataVM.setupDataProduct(data: data!)
        }
    }
    
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
