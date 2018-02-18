//
//  GnomeRoute.swift
//  knowTheGnome
//
//  Created by Aitor Pagán on 18/2/18.
//  Copyright © 2018 Aitor Pagán. All rights reserved.
//

import Foundation
import Alamofire

class GnomeRoute {
    
    enum EndPoint : String {
        case getGnomes = "mobile_test/master/data.json"
    }
    
    func getGnomes(in city: String, completion: @escaping (Result<[Gnome]>) -> ()) {
        
        let url = AppApiConfig.base_url.appending(EndPoint.getGnomes.rawValue)
        
        NetworkManager.shared.request(url, method: .get).responseJSON { (response) in
            switch response.result {
            case .success(let value):
                do {
                    if let town = value as? [String : Any], let data = town[city] as? [[String : Any]] {
                        let gnomes : [Gnome] = try data.map() {
                            return try Gnome(from: $0)
                        }
                        let result = Result.success(data: gnomes)
                        completion(result)
                    }
                } catch let error {
                    let result = Result<[Gnome]>.error(error)
                    completion(result)
                }
            case .failure(let error):
                let result = Result<[Gnome]>.error(error)
                completion(result)
            }
        }
    }
}
