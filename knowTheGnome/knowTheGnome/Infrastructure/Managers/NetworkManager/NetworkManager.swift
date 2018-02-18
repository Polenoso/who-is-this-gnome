//
//  NetworkManager.swift
//  knowTheGnome
//
//  Created by Aitor Pagán on 18/2/18.
//  Copyright © 2018 Aitor Pagán. All rights reserved.
//

import Foundation
import Alamofire

private struct Timeout {
    
    static let secondsForRequest = 30.0 // secs
    static let secondsForResource = 30.0 // secs
}

class NetworkManager : SessionManager {
    static let shared = NetworkManager()
    private let reachabilityManager: NetworkReachabilityManager?
    
    private class func defaultConfiguration() -> URLSessionConfiguration {
        
        let additionalHeaders = ["Content-Type": "application/json; charset=utf-8", "Cache-Control": "no-cache"]
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = Timeout.secondsForRequest
        sessionConfig.timeoutIntervalForResource = Timeout.secondsForResource
        sessionConfig.httpAdditionalHeaders = additionalHeaders
        
        return sessionConfig
    }
    
    // MARK: - Init
    init() {
        
        reachabilityManager = NetworkReachabilityManager()
        
        super.init(configuration: NetworkManager.defaultConfiguration())
    }
}
