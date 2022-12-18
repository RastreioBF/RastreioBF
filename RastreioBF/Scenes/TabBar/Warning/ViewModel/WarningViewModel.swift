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
    
    
    func setupDataProduct(data: DataProduct) {
        WarningViewControllerViewModel.data.append(data)
    }
    
    func setupDataTracking(data: DataTracking) {
        WarningViewControllerViewModel.dataHeader.append(data)
    }
    
    func getDataProduct(indexPath: IndexPath) -> DataProduct {
        return WarningViewControllerViewModel.data[indexPath.row]
    }
    
//    func loadCurrentDetailAccountList(indexPath: IndexPath) -> Eventos {
//        var newPackage = Eventos(
//            data: nil,
//            hora: nil,
//            local: nil,
//            status: nil,
//            subStatus: nil
//        )
//        if let currentPackage = package?.eventos?[indexPath.row] {
//            let lastEvent = package?.eventos?.first
//            newPackage = Eventos(
//                data: lastEvent?.data,
//                hora: lastEvent?.hora,
//                local: lastEvent?.local,
//                status: lastEvent?.status,
//                subStatus: nil
//            )
//        }
//
//        return newPackage
//    }
    
    
    func loadCurrentDetailAccountList() -> Eventos {
        return package?.eventos?[0] ?? Eventos(data: "", hora: "", local: "", status: "", subStatus: [""])
    }
    
    var dataArraySize: Int {
        return WarningViewControllerViewModel.data.count
    }
    
    func removeData(indexPath: IndexPath) {
        WarningViewControllerViewModel.data.remove(at: indexPath.row)
    }
    
    var heightForRowAt: CGFloat {
        return 125
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
    
//    func updatePackages() {
//        packages = CoreDataManager.shared.fetchPackages()
//        let dispatchGroup = DispatchGroup()
//
//        packages.forEach { (package) in
//            dispatchGroup.enter()
//            guard let trackingNumber = package.trackingNumber else { return }
//            guard let carrier        = package.carrier else { return }
//
//            BackendService.shared.getTrackingInfo(for: trackingNumber, carrier: carrier) { (trackingResponseJSON, error) in
//                if let error = error {
//                    fatalError("error updating package \(error)")
//                }
//                guard let trackingResponseJSON = trackingResponseJSON else { return }
//                CoreDataManager.shared.updatePackage(package: package, trackingJson: trackingResponseJSON)
//
//                (package.trackingHistory?.array as! [TrackingStatus]).forEach { (trackingStatus) in
//                    let location      = trackingStatus.location
//                    guard let city    = location?.city else { return }
//                    guard let state   = location?.state else { return }
//                    guard let country = location?.country else { return }
//
//                    GeocodingService.shared.getGeocode(city: city, state: state, country: country) { (coordinate, error) in
//                        if let err = error {
//                            print(err)
//                        }
//
//                        guard let coordinate = coordinate else { return }
//                        CoreDataManager.shared.updateGeolocation(for: trackingStatus, latitude: coordinate.latitude, longitude: coordinate.longitude)
//                    }
//                }
//
//                dispatchGroup.leave()
//            }
//        }
//
//        dispatchGroup.notify(queue: .main) {
//            self.delegate?.didUpdatePackages()
//        }
//    }
//

}
