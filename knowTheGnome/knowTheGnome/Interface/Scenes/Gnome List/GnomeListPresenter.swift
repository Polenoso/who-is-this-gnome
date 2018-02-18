//
//  GnomeListPresenter.swift
//  knowTheGnome
//
//  Created by Aitor Pagán on 18/2/18.
//  Copyright © 2018 Aitor Pagán. All rights reserved.
//

import Foundation

protocol GnomeListViewOutput: class {
    func displayErrorOnRetrieve(title: String, message: String)
    func displayGnomes(data: [DisplayedGnomes])
    func displayLoading()
}

protocol GnomeListPresenter {
    func getGnomes()
}

class GnomeListPresenterImpl: GnomeListPresenter{
    
    // View reference
    weak var output : GnomeListViewOutput?
    
    // Data storage
    var gnomes : [Gnome]?
    
    // Business services
    var gnomeService : GnomeService = GnomeServiceImpl()
    
    init(with output: GnomeListViewOutput) {
        self.output = output
    }
    
    //MARK: Input Business Logic
    func getGnomes() {
        output?.displayLoading()
        
        gnomeService.getGnomes({ [weak self] (gnomes) in
            self?.gnomes = gnomes
            let displayedGnomes : [DisplayedGnomes] = gnomes.map() {
                let age = "\($0.age ?? 0)"
                let assetForGender = self?.assetNameForGender() ?? "he"
                return DisplayedGnomes(asset: assetForGender, name: $0.name ?? " ", age: age, weight: $0.weight?.format(f: ".2") ?? "", height: $0.height?.format(f: ".2") ?? "")
            }
            self?.output?.displayGnomes(data: displayedGnomes)
        }) { [weak self] (error) in
            let errorTitle = "Error"
            let errorMessage = error.localizedDescription
            self?.output?.displayErrorOnRetrieve(title: errorTitle, message: errorMessage)
        }
    }
    
    private func assetNameForGender() -> String {
        enum Assetname : String {
            case he = "he"
            case she = "she"
        }
        
        let randomnum = Int(arc4random_uniform(100))
        
        if randomnum % 2 == 0 {
            return Assetname.he.rawValue
        }else {
            return Assetname.she.rawValue
        }
    }
}
