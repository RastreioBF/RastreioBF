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
    
//    let urlString: String = "https://api.linketrack.com/track/json?user=teste&token=1abcd00b2731640e886fb41a8a9671ad1434c599dbaa0a0de9a5aa619f29a83f&codigo="
    
    //link completo https://run.mocky.io/v3/aa32440f-359d-49ae-9a20-6d3bb3ea2edf
    let urlString: String = "https://run.mocky.io/v3/aa32440f-359d-49ae-9a20-"
    
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
    
}
