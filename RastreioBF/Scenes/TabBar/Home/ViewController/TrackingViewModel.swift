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

class TrackingViewControllerViewModel {
    
    private var warningDataVM = WarningViewControllerViewModel()
    private var doneDataVM = DoneViewControllerViewModel()
    private var pendingDataVM  = PendenciesViewControllerViewModel()
    private var detailDataVM  = DetailWarningViewControllerViewModel()
    
    private static var data : [DataProduct] = []
    private static var dataHeader: [DataTracking] = []
    private static var model: [Eventos] = []
    var coreData = [DataProduct]()
    var delegate: TrackingViewModelDelegate?
    
    func getLastData() -> DataProduct? {
        return TrackingViewControllerViewModel.data.last
    }
    
    func getLastDataHeader() -> Eventos? {
        return TrackingViewControllerViewModel.model.last
    }
    
    func setupDataProduct(data: DataProduct) {
        TrackingViewControllerViewModel.data.append(data)
    }
    
    init() {
        getCoreDataPackages()
    }
    
    func getCoreDataPackages() {
        coreData = CoreDataManager.shared.fetchPackages()
        delegate?.didUpdatePackages()
    }
    
   public func updatePackages() {
        coreData = CoreDataManager.shared.fetchPackages()
        let dispatchGroup = DispatchGroup()

        coreData.forEach ({ coreData in
            dispatchGroup.enter()
            let code = coreData.codeTraking
            guard coreData.productName != nil else { return }
            
            RastreioBFService.sharedObjc.getTrackingInfo(for: code ?? "") { (trackingResponseJSON, error) in
                if let error = error {
                    fatalError("error updating package \(error)")
                }
                guard let trackingResponseJSON = trackingResponseJSON else { return }
                CoreDataManager.shared.updatePackage(package: coreData, trackingJson: trackingResponseJSON)
    
                dispatchGroup.leave()
            }})
        
        dispatchGroup.notify(queue: .main) {
            self.delegate?.didUpdatePackages()
        }
    }
    
    private func updatePackage(package: DataProduct) {
        guard let trackingNumber = package.codeTraking else { return }

        RastreioBFService.sharedObjc.getTrackingInfo(for: trackingNumber) { (trackingResponseJSON, error) in
            if let error = error {
                fatalError("error updating package \(error)")
            }
            guard let trackingResponseJSON = trackingResponseJSON else { return }
            
            CoreDataManager.shared.updatePackage(package: package, trackingJson: trackingResponseJSON)

            DispatchQueue.main.async {
                self.delegate?.didUpdatePackages()
            }
        }
    }
    
    func addPackage(name: String, trackingNumber: String) {
        let package = CoreDataManager.shared.addPackage(name: name, trackingNumber: trackingNumber)
        coreData.append(package)
        updatePackage(package: package)
    }
    
}
    
