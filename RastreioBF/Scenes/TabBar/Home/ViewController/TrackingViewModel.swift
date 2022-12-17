//
//  TrackingViewModel.swift
//  RastreioBF
//
//  Created by Anderson Sales on 03/12/22.
//

import Foundation

struct TrackingViewControllerViewModel {
    
    private var warningDataVM = WarningViewControllerViewModel()
    private var doneDataVM = DoneViewControllerViewModel()
    private var pendingDataVM  = PendenciesViewControllerViewModel()
    private var detailDataVM  = DetailWarningViewControllerViewModel()
    
    private static var data : [DataProduct] = []
    private static var dataHeader: [DataTracking] = []
    private static var model: [Eventos] = []
    
    func populateCorrectArray(data: DataProduct?, model: Eventos?){
//        if data?.status.lowercased() == "entregue" {
//            doneDataVM.setupDataProduct(data: DataProduct(
//                productName: data?.productName ?? "",
//                productNameImage: "done",
//                codeTraking: data?.codeTraking ?? "",
//                productDescription: data?.productDescription ?? "",
//                date: data?.date ?? "DD/MM/AAAA",
//                time: data?.time ?? "HH:MM",
//                status: data?.status ?? "pending"))
//
//            warningDataVM.setupDataProduct(data: DataProduct(
//                productName: data?.productName ?? "",
//                productNameImage: "new",
//                codeTraking: data?.codeTraking ?? "",
//                productDescription: data?.productDescription ?? "",
//                date: data?.date ?? "DD/MM/AAAA",
//                time: data?.time ?? "HH:MM",
//                status: data?.status ?? ""))
//
//            detailDataVM.setupDataProduct(data: DataProduct(
//                productName: data?.productName ?? "",
//                productNameImage: "new",
//                codeTraking: data?.codeTraking ?? "",
//                productDescription: data?.productDescription ?? "",
//                date: data?.date ?? "DD/MM/AAAA",
//                time: data?.time ?? "HH:MM",
//                status: data?.status ?? ""))
//
//
//        } else if data?.status.lowercased() == "pendente" {
//            pendingDataVM.setupDataProduct(data: DataProduct(
//                productName: data?.productName ?? "",
//                productNameImage: "errorImage",
//                codeTraking: data?.codeTraking ?? "",
//                productDescription: data?.productDescription ?? "",
//                date: data?.date ?? "DD/MM/AAAA",
//                time: data?.time ?? "HH:MM",
//                status: data?.status ?? "pending"))
//
//            warningDataVM.setupDataProduct(data: DataProduct(
//                productName: data?.productName ?? "",
//                productNameImage: "new",
//                codeTraking: data?.codeTraking ?? "",
//                productDescription: data?.productDescription ?? "",
//                date: data?.date ?? "DD/MM/AAAA",
//                time: data?.time ?? "HH:MM",
//                status: data?.status ?? ""))
//
//            detailDataVM.setupDataProduct(data: DataProduct(
//                productName: data?.productName ?? "",
//                productNameImage: "new",
//                codeTraking: data?.codeTraking ?? "",
//                productDescription: data?.productDescription ?? "",
//                date: data?.date ?? "DD/MM/AAAA",
//                time: data?.time ?? "HH:MM",
//                status: data?.status ?? ""))
//
//        } else {
            warningDataVM.setupDataProduct(data: DataProduct(
                productName: data?.productName ?? "",
                productNameImage: "new",
                codeTraking: data?.codeTraking ?? "",
                productDescription: model?.status ?? "",
                date: model?.data ?? "DD/MM/AAAA",
                time: model?.hora ?? "HH:MM",
                status: model?.local ?? ""))
            
            detailDataVM.setupDataProduct(data: DataProduct(
                productName: data?.productName ?? "",
                productNameImage: "new",
                codeTraking: data?.codeTraking ?? "",
                productDescription: model?.status ?? "",
                date: model?.data ?? "DD/MM/AAAA",
                time: model?.hora ?? "HH:MM",
                status: model?.local ?? ""))
//        }
    }
    
    func addData(data: DataTracking?){
        warningDataVM.setupDataTracking(data: DataTracking(
            code: data?.code ?? "",
            description: data?.description ?? ""))
    }
    
    func getLastData() -> DataProduct? {
        return TrackingViewControllerViewModel.data.last
    }
    
    func getLastDataHeader() -> Eventos? {
        return TrackingViewControllerViewModel.model.last
    }
    
    mutating func setupDataTracking(dataTracking: DataTracking){
        TrackingViewControllerViewModel.dataHeader.append(dataTracking)
    }
    
    mutating func setupDataProduct(data: DataProduct) {
        TrackingViewControllerViewModel.data.append(data)
    }
    
}
