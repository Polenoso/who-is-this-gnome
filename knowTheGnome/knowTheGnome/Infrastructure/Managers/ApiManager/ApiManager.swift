//
//  ApiManager.swift
//  knowTheGnome
//
//  Created by Aitor Pagán on 18/2/18.
//  Copyright © 2018 Aitor Pagán. All rights reserved.
//

import Foundation
import Alamofire

class ApiManager {
    static let sharedInstance: ApiManager = ApiManager()
    
    private init() {}
    
    let gnomeRoute : GnomeRoute = GnomeRoute()
}
