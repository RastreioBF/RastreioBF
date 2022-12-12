//
//  RastreioBFService.swift
//  RastreioBF
//
//  Created by Jessica Bigal on 17/11/22.
//

import Foundation

class RastreioBFService {
    
    static let sharedObjc = RastreioBFService()

    private init() { }

    func getPackage(packageCode: String, completion: @escaping ([Eventos]?, Error?) -> Void) {
        guard let url = URL(string: "https://api.linketrack.com/track/json?user=teste&token=1abcd00b2731640e886fb41a8a9671ad1434c599dbaa0a0de9a5aa619f29a83f&codigo=" + packageCode) else {return}
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
    
}
