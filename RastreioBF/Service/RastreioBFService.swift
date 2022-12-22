//
//  RastreioBFService.swift
//  RastreioBF
//
//  Created by Jessica Bigal on 17/11/22.
//

import Foundation
import Alamofire

protocol RastreioBFServiceProtocol: GenericService {
    func getPackage(packageCode: String, completion: @escaping ([Eventos]?, Error?) -> Void)
    func getPackageURLSession(packageCode: String, completion: @escaping completion<Package?>)
    func getPackageFromJson(completion: completion<Package?>)
    func getPackageAlamofire(packageCode: String, completion: @escaping completion<Package?>)
}

class RastreioBFService: RastreioBFServiceProtocol {
    
    static let sharedObjc = RastreioBFService()
    
//    let urlString: String = "https://api.linketrack.com/track/json?user=jessicabigal21@outlook.com&token=af29d01cc3d2a0d9d25b7d560bdf671416e9055b6f1f087c091c015fe8c7ec1d&codigo=
    
    //link completo https://run.mocky.io/v3/aa32440f-359d-49ae-9a20-6d3bb3ea2edf
    // link 2 https://run.mocky.io/v3/eaf1d197-5ad6-4bcd-bc54-b3c76ac7611f
    let urlString: String = "https://run.mocky.io/v3/"
    
    init() { }
    
    func getPackage(packageCode: String, completion: @escaping ([Eventos]?, Error?) -> Void) {
        
        guard let url = URL(string: urlString + packageCode) else {return}
        let session = URLSession.shared
        
        session.configuration.timeoutIntervalForResource = 5
        let task = session.dataTask(with: url) { data, response, error in
            guard let data = data else {return}
            do {
                let decoder = JSONDecoder()
                let model = try decoder.decode(Package.self, from: data)
                completion(model.eventos, nil)
            } catch {
                print("Error")
            }
        }
        task.resume()
    }
    
    func getPackageURLSession(packageCode: String,completion: @escaping completion<Package?>) {
        
        guard let url: URL = URL(string: urlString + packageCode) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let dataResult =  data else { return }
            
            guard let response = response as? HTTPURLResponse else { return }
            
            if response.statusCode == 200 {
                do{
                    let data = try Data(contentsOf: url)
                    let package: Package = try JSONDecoder().decode(Package.self, from: dataResult)
                    completion(package,nil)
                } catch {
                    completion(nil, error)
                }
            } else {
                print("deu ruim")
            }
        }
        
        task.resume()
    }
    
    func getPackageURLSessionNoLink(completion: @escaping completion<Package?>) {
        
        guard let url: URL = URL(string: "https://run.mocky.io/v3/aa32440f-359d-49ae-9a20-6d3bb3ea2edf") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let dataResult =  data else { return }
            
            guard let response = response as? HTTPURLResponse else { return }
            
            if response.statusCode == 200 {
                do{
                    let data = try Data(contentsOf: url)
                    let package: Package = try JSONDecoder().decode(Package.self, from: dataResult)
                    completion(package,nil)
                } catch {
                    completion(nil, error)
                }
            } else {
                print("deu ruim")
            }
        }
        
        task.resume()
    }
    
    func getPackageFromJson(completion: completion<Package?>) {
        if let url = Bundle.main.url(forResource: "RastreioTemplate", withExtension: "json"){
            do{
                let data = try Data(contentsOf: url)
                let package: Package = try JSONDecoder().decode(Package.self, from: data)
                completion(package,nil)
            } catch {
                completion(nil, error)
            }
        }
    }
    
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

