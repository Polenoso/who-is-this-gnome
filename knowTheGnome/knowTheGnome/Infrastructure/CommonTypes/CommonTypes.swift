//
//  CommonTypes.swift
//  knowTheGnome
//
//  Created by Aitor Pagán on 18/2/18.
//  Copyright © 2018 Aitor Pagán. All rights reserved.
//

import Foundation

enum ReturnError : Error {
    case invalidJson
    case generic(String)
}

enum Result<T> {
    case success(data: T)
    case error(Error)
}
