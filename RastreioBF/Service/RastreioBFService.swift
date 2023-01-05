//
//  RastreioBFService.swift
//  RastreioBF
//
//  Created by Jessica Bigal on 17/11/22.
//

import Foundation
import Alamofire

protocol RastreioBFServiceProtocol: GenericService {
    func getTrackingInfo(for trackingNumber: String, completion: @escaping (Package?, Error?) -> Void)
    func getPackageAlamofire(packageCode: String, completion: @escaping completion<Package?>)
}

class RastreioBFService: RastreioBFServiceProtocol {
    
    static let sharedObjc = RastreioBFService()
    
    let urlString: String = LC.urlAPI.text
    
    init() { }
    
    func getPackageAlamofire(packageCode: String, completion: @escaping completion<Package?>) {
        guard let urlString: URL = URL(string: urlString + packageCode) else { return }
        AF.request(urlString, method: .get).responseDecodable(of: Package.self){ response in
            debugPrint(response)
            switch response.result {
            case .success(let success):
                completion(success,nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
    
    func getTrackingInfo(for trackingNumber: String, completion: @escaping (Package?, Error?) -> Void) {
        guard let urlString: URL = URL(string: urlString + trackingNumber) else { return }
        let request = URLRequest(url: urlString)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Failed to fetch json: ", error)
                completion(nil, error)
            }
            
            guard let data = data else { return }
            
            let jsonDecoder = JSONDecoder()
            do {
                let trackingInfo = try jsonDecoder.decode(Package.self, from: data)
                completion(trackingInfo, nil)
            } catch let decodeErr {
                print("Failed to decode json: ", decodeErr)
                completion(nil, decodeErr)
            }
        }.resume()
    }
    
}
