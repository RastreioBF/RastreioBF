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
    private var package: Package?
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
    
    func getDataProduct(indexPath: IndexPath) -> DataProduct {
        return WarningViewControllerViewModel.data[indexPath.row]
    }
    
//    func getDataProduct(indexPath: IndexPath) -> DataTracking {
//        return WarningViewControllerViewModel.dataHeader[indexPath.row]
//    }
    
//    func getDataProduct(indexPath: IndexPath) -> Eventos {
//        return WarningViewControllerViewModel.dataHeader[indexPath.row]
//    }
    
    var dataArraySize: Int {
        return WarningViewControllerViewModel.dataHeader.count
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

}
