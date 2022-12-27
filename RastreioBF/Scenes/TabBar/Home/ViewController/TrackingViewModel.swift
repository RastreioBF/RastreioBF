//
//  TrackingViewModel.swift
//  RastreioBF
//
//  Created by Anderson Sales on 03/12/22.
//

import Foundation
import CoreData

protocol TrackingViewModelDelegate {
    func didUpdatePackages()
    func success()
    func failure()
}

class TrackingViewControllerViewModel {
    
    private let service: RastreioBFService = RastreioBFService()
    private static var data: [DataProduct] = []
    private static var model: [Events] = []
    private var package: Package?
    private var coreData = [DataProduct]()
    private var delegate: TrackingViewModelDelegate?
    
    func accessDelegate(delegate: TrackingViewModelDelegate?) {
        self.delegate = delegate
    }
    
    init() {
        getCoreDataPackages()
    }
    
    private func getCoreDataPackages() {
        coreData = CoreDataManager.shared.fetchPackages()
        delegate?.didUpdatePackages()
    }
    
    private func updatePackages() {
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
    
    func fetchHistory(code: String){
        service.getPackageAlamofire(packageCode: code) { result, failure in
            if let result = result {
                self.package =  result
                self.delegate?.success()
            } else {
                self.delegate?.failure()
            }
        }
    }
    
    func checkTextFieldsAreNotEmpty(name:String, trackingNumber: String ) -> Bool {
        if trackingNumber.isEmpty || trackingNumber.hasPrefix(" ") || name.isEmpty || name.hasPrefix(" ") {
            return false
        } else {
            return true
        }
    }
    
    func addPackage(name: String, trackingNumber: String) {
        let package = CoreDataManager.shared.addPackage(name: name, trackingNumber: trackingNumber)
        coreData.append(package)
        updatePackage(package: package)
    }
    
    func getPackageName(indexPath: IndexPath) -> String? {
        return coreData[indexPath.row].productDescription
    }
}
