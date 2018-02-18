//
//  GnomeService.swift
//  knowTheGnome
//
//  Created by Aitor Pagán on 18/2/18.
//  Copyright © 2018 Aitor Pagán. All rights reserved.
//

import Foundation

typealias GetGnomesSuccessHandler = ([Gnome]) -> ()
typealias GetGnomesErrorHandler = (Error) -> ()

protocol GnomeService: class {
    func getGnomes(_ successHandler: @escaping GetGnomesSuccessHandler, errorHandler: @escaping GetGnomesErrorHandler)
}

class GnomeServiceImpl: GnomeService {
    
    static var cachedGnomes : [Gnome]?
    
    func clearCachedGnomes() {
        GnomeServiceImpl.cachedGnomes = nil
    }
    
    func getGnomes(_ successHandler: @escaping GetGnomesSuccessHandler, errorHandler: @escaping GetGnomesErrorHandler) {
        
        ApiManager.sharedInstance.gnomeRoute.getGnomes(in: "Brastlewark") { (result) in
            switch result {
            case .success(data: let gnomes):
                GnomeServiceImpl.cachedGnomes = gnomes
                successHandler(gnomes)
            case .error(let error):
                errorHandler(error)
            }
        }
    }
}
