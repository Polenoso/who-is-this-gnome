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
    func filter(with: String?, sortedBy: String)
}

enum SortStyle : String {
    case byAge = "age"
    case byWeight = "weight"
    case byHeight = "height"
    case byDefault = "default" //By id
    
    init(from: String){
        self = SortStyle(rawValue: from) ?? .byDefault
    }
}

enum SortOrder {
    case asc
    case desc
}

class GnomeListPresenterImpl: GnomeListPresenter{
    
    // View reference
    weak var output : GnomeListViewOutput?
    
    // Data storage
    var gnomes : [Gnome]?
    
    // Business services
    var gnomeService : GnomeService = GnomeServiceImpl()
    
    // Helpers
    var filteredList : [Gnome]?
    var sortStyle : SortStyle = .byDefault
    var sortOrder : SortOrder = .asc
    
    init(with output: GnomeListViewOutput) {
        self.output = output
    }
    
    //MARK: Input Business Logic
    func getGnomes() {
        output?.displayLoading()
        
        gnomeService.getGnomes({ [weak self] (gnomes) in
            self?.gnomes = self?.sortGnomes(list: gnomes)
            let displayedGnomes : [DisplayedGnomes] = gnomes.map() {
                let age = "\($0.age ?? 0)"
                let assetForGender = self?.assetNameForGender(id: $0.id!) ?? "he"
                return DisplayedGnomes(asset: assetForGender, name: $0.name ?? " ", age: age, weight: $0.weight?.format(f: ".2") ?? "", height: $0.height?.format(f: ".2") ?? "")
            }
            self?.output?.displayGnomes(data: displayedGnomes)
        }) { [weak self] (error) in
            let errorTitle = "Error"
            let errorMessage = error.localizedDescription
            self?.output?.displayErrorOnRetrieve(title: errorTitle, message: errorMessage)
        }
    }
    
    func filter(with: String?, sortedBy: String) {
        guard var list = gnomes else {
            let errorTitle = "Error"
            let errorMessage = "Unknown Error"
            self.output?.displayErrorOnRetrieve(title: errorTitle, message: errorMessage)
            return
        }
        sortStyle = SortStyle(from: sortedBy)
        list = sortGnomes(list: list)
        gnomes = list
        if filteredList != nil {
            list = filteredList!
        }
        if (with ?? "").isEmpty {
            filteredList = nil
        } else {
            filteredList = list.filter() {
                guard let name = $0.name else { return true }
                return name.contains("\(with ?? "")")
            }
            list = filteredList ?? []
        }
        let displayedGnomes : [DisplayedGnomes] = list.map() {
            let age = "\($0.age ?? 0)"
            let assetForGender = self.assetNameForGender(id: $0.id!)
            return DisplayedGnomes(asset: assetForGender, name: $0.name ?? " ", age: age, weight: $0.weight?.format(f: ".2") ?? "", height: $0.height?.format(f: ".2") ?? "")
        }
        self.output?.displayGnomes(data: displayedGnomes)
    }
    
    //MARK: Helpers
    private func assetNameForGender(id: Int) -> String {
        enum Assetname : String {
            case he = "he"
            case she = "she"
        }
        
        if id % 2 == 0 {
            return Assetname.he.rawValue
        }else {
            return Assetname.she.rawValue
        }
    }
    
    private func sortGnomes(list: [Gnome]) -> [Gnome] {
        let sorted = list.sorted(by: { (lhs, rhs) -> Bool in
            switch self.sortStyle {
            case .byAge:
                guard let leftAge = lhs.age, let rightAge = lhs.age else { return true }
                if self.sortOrder == .asc {
                    return leftAge < rightAge
                }else {
                    return leftAge > rightAge
                }
            case .byHeight:
                guard let leftHeight = lhs.height, let rightHeight = rhs.height else { return true }
                if self.sortOrder == .asc {
                    return leftHeight < rightHeight
                } else {
                    return leftHeight > rightHeight
                }
            case .byWeight:
                guard let leftWeight = lhs.weight, let rightWeight = rhs.weight else { return true }
                if self.sortOrder == .asc {
                    return leftWeight < rightWeight
                } else {
                    return leftWeight > rightWeight
                }
            case .byDefault:
                guard let leftId = lhs.id, let rightId = rhs.id else { return true }
                if self.sortOrder == .asc {
                    return leftId < rightId
                } else {
                    return leftId > rightId
                }
            }
        })
        return sorted
    }
}
