//
//  GnomeDetailPresenter.swift
//  knowTheGnome
//
//  Created by Pagán Narro, Aitor on 20/02/2018.
//  Copyright © 2018 Aitor Pagán. All rights reserved.
//

import Foundation

protocol GnomeDetailViewOutput : class {
    func displayGnome(data: DisplayedGnome)
}

protocol GnomeDetailPresenter : class {
    func getGnome()
    
    weak var output : GnomeDetailViewOutput? {get set}
}

class GnomeDetailPresenterImpl : GnomeDetailPresenter {
    
    weak var output: GnomeDetailViewOutput?
    
    //MARK: Business logic
    func getGnome(){
        
    }
}
