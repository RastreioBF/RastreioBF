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

class WarningViewModel {
    
    private var coreData = [DataProduct]()
    private var coreDataDP = DataProduct()
    private var eventArray = [DataProduct]()
    private var package: Package?
    private weak var delegate: WarningViewModelProtocols?
    private let service: RastreioBFService = RastreioBFService()
    private var coreDataStack = CoreDataStack(modelName: LC.dataProduct.text)
    
    func setEventArray(eventArray: [DataProduct]) {
        self.eventArray = eventArray
    }
    
    func getEventArray(indexPath: IndexPath) -> DataProduct {
        return eventArray[indexPath.row]
    }
    
    public func delegate(delegate: WarningViewModelProtocols?){
        self.delegate = delegate
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
    
    func handle(_ result: Result<[DataProduct], Error>) {
        switch result {
        case .success(let coreData):
            DispatchQueue.main.async {
                self.coreData = coreData
                self.delegate?.success()
            }
        case .failure(_):
            self.delegate?.failure()
        }
    }
    
    func fetchRequestWithTemplate(named: String) {
        coreDataStack.fetch(requestName: named, ofType: DataProduct.self) { (result) in
            self.handle(result)
        }
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
    
    private func getCoreDataPackages() {
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

