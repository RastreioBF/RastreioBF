//
//  TrackingViewModel.swift
//  RastreioBF
//
//  Created by Anderson Sales on 03/12/22.
//

import Foundation

protocol TrackingViewModelDelegate {
    func didUpdatePackages()
}

struct TrackingViewControllerViewModel {
    
    private var warningDataVM = WarningViewControllerViewModel()
    private var doneDataVM = DoneViewControllerViewModel()
    private var pendingDataVM  = PendenciesViewControllerViewModel()
    private var detailDataVM  = DetailWarningViewControllerViewModel()
    
    private static var data : [DataProduct] = []
    private static var dataHeader: [DataTracking] = []
    private static var model: [Eventos] = []
    var coreData = [DataProduct]()
    var delegate: TrackingViewModelDelegate?
    
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
    
    init() {
//        CoreDataManager.shared.deleteAllPackages()
        getCoreDataPackages()
    }
    
    private mutating func getCoreDataPackages() {
//        coreData = CoreDataManager.shared.fetchPackages()
//        delegate?.didUpdatePackages()
    }
    
    mutating func updatePackages() {
//        coreData = CoreDataManager.shared.fetchPackages()
//        let dispatchGroup = DispatchGroup()
//
//        coreData.forEach ({ coreData in
//            dispatchGroup.enter()
//            let code = coreData.codeTraking
////            guard let name = coreData.productName else { return }
//
//            RastreioBFService.sharedObjc.getTrackingInfo(for: code ?? "") { (trackingResponseJSON, error) in
//                if let error = error {
//                    fatalError("error updating package \(error)")
//                }
//                guard let trackingResponseJSON = trackingResponseJSON else { return }
//                CoreDataManager.shared.updatePackage(package: coreData, trackingJson: trackingResponseJSON)
////
//                (coreData.status.array as! [TrackingStatus]).forEach { (trackingStatus) in
//                    let location      = trackingStatus.location
//                    guard let city    = location?.city else { return }
//                    guard let state   = location?.state else { return }
//                    guard let country = location?.country else { return }
//                }
//
//                dispatchGroup.leave()
//            })
        
//        dispatchGroup.notify(queue: .main) {
//            self.delegate?.didUpdatePackages()
//        }
    }
    
    private func updatePackage(package: DataProduct) {
//        guard let trackingNumber = package.codeTraking else { return }
//        guard let name        = package.productDescription else { return }
//
//        RastreioBFService.sharedObjc.getTrackingInfo(for: trackingNumber) { (trackingResponseJSON, error) in
//            if let error = error {
//                fatalError("error updating package \(error)")
//            }
//            guard let trackingResponseJSON = trackingResponseJSON else { return }
//            CoreDataManager.shared.updatePackage(package: package, trackingJson: trackingResponseJSON)
//
//            // TODO: update geolocation as well
//
//            DispatchQueue.main.async {
//                self.delegate?.didUpdatePackages()
//            }
//        }
    }
    
    mutating func addPackage(name: String, trackingNumber: String) {
//        let package = CoreDataManager.shared.addPackage(name: name, trackingNumber: trackingNumber)
////        TrackingViewControllerViewModel.coreData.append(DataProduct)
//        coreData.append(package)
//        updatePackage(package: package)
    }
    
}
