//
//  DataProductViewModel.swift
//  RastreioBF
//
//  Created by Anderson Sales on 03/12/22.
//

import Foundation

protocol WarningViewModelProtocols: AnyObject {
    func success()
    func failure()
    func didUpdatePackages()
}

class WarningViewControllerViewModel {
    
    private let service: RastreioBFService = RastreioBFService()
    var package: Package?
    weak var delegate: WarningViewModelProtocols?
    
    public func delegate(delegate: WarningViewModelProtocols?){
        self.delegate = delegate
    }
    
    private static var data : [DataProduct] = []
    private static var dataHeader : [DataTracking] = []
    private static var events : [Eventos] = []
    var coreData = [DataProduct]()
    
    
    func setupDataProduct(data: DataProduct) {
        WarningViewControllerViewModel.data.append(data)
    }
    
    func getDataProduct(indexPath: IndexPath) -> DataProduct {
        return coreData[indexPath.row]
    }
    
    var dataArraySize: Int {
        return coreData.count
    }
    
    func removeData(indexPath: IndexPath) {
        coreData.remove(at: indexPath.row)
    }
    
    var heightForRowAt: CGFloat {
        return 115
    }
    
    func fetchPackageAlamofire(code: String){
        service.getPackageAlamofire(packageCode: code) { result, failure in
            if let result = result {
                self.package =  result
                self.delegate?.success()
            } else {
                self.delegate?.failure()
            }
        }
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
            guard let code = coreData.codeTraking else { return }
            
            RastreioBFService.sharedObjc.getTrackingInfo(for: code ) { (trackingResponseJSON, error) in
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
    
  func updatePackage(package: DataProduct) {
        guard let trackingNumber = package.codeTraking else { return }
        guard package.productDescription != nil else { return }
        
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
    
}

