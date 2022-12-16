//
//  DetailWarningViewModel.swift
//  RastreioBF
//
//  Created by Anderson Sales on 04/12/22.
//

import Foundation
import Alamofire

protocol DetailWarningViewModelProtocols: AnyObject {
    func success()
    func failure()
}

class DetailWarningViewControllerViewModel {
    
    private let service: RastreioBFService = RastreioBFService()
    private var package: Package?
    weak var delegate: DetailWarningViewModelProtocols?
    private static var data : [DataProduct] = []
    
    public func delegate(delegate: DetailWarningViewModelProtocols?){
        self.delegate = delegate
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
    
    func fetchPackageURLSession(code: String){
        service.getPackageURLSession(packageCode: code) { result, failure in
            if let result = result {
                self.package =  result
                self.delegate?.success()
            } else {
                self.delegate?.failure()
            }
        }
    }
    
    func fetchPackage(){
        service.getPackageFromJson { result, failure in
            if let result = result {
                self.package =  result
                self.delegate?.success()
            } else {
                self.delegate?.failure()
            }
        }
    }
    
    func fetchPackageURLSessionNoLink(){
        service.getPackageURLSessionNoLink { result, failure in
            if let result = result {
                self.package =  result
                self.delegate?.success()
            } else {
                self.delegate?.failure()
            }
        }
    }
    
    var numberaOfRowsInSection: Int {
        return package?.eventos?.count ?? 0
    }
    
    var heightForRowAt: CGFloat {
        return 80
    }
    
    func loadCurrentDetailAccountList(indexPath: IndexPath) -> Eventos {
        return package?.eventos?[indexPath.row] ?? Eventos(data: "", hora: "", local: "", status: "", subStatus: [""])
    }
    
    func setupDataProduct(data: DataProduct) {
        DetailWarningViewControllerViewModel.data.append(data)
    }

}

