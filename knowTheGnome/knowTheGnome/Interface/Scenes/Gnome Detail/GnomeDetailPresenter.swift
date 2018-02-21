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
    var selectedGnome : Gnome? {get set}
}

class GnomeDetailPresenterImpl : GnomeDetailPresenter {
    
    weak var output: GnomeDetailViewOutput?
    var selectedGnome : Gnome?
    //MARK: Business logic
    func getGnome(){
        let age = "Age >> \(selectedGnome?.age ?? 0) Years <<"
        let weight = "\(selectedGnome?.weight?.format(f: ".2") ?? "") g."
        let height = "\(selectedGnome?.height?.format(f: ".2") ?? "") cm."
        let displayedGnome = DisplayedGnome(image: selectedGnome?.thumbnail, name: selectedGnome?.name ?? " ", age: age, weight: weight, height: height, hairColor: selectedGnome?.hair_color ?? " ", jobs: selectedGnome?.professions ?? [], friends: selectedGnome?.friends ?? [])
        output?.displayGnome(data: displayedGnome)
    }
}
