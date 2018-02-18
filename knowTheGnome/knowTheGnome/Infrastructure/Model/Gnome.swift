//
//  Gnome.swift
//  knowTheGnome
//
//  Created by Aitor Pagán on 18/2/18.
//  Copyright © 2018 Aitor Pagán. All rights reserved.
//

import Foundation

struct Gnome{
    let id: Int?
    let name: String?
    let thumbnail: URL?
    let age: Int?
    let weight: Double?
    let height: Double?
    let hair_color: String?
    let professions: [String]?
    let friends: [String]?
}

extension Gnome {
    init(from data: [String : Any]) throws {
        do {
            guard let iden = data["id"] as? NSNumber else { throw ReturnError.invalidJson }
            id = iden.intValue
            name = data["name"] as? String
            guard let thumb = data["thumbnail"] as? String, let url = URL(string: thumb) else { throw ReturnError.invalidJson }
            thumbnail = url
            guard let old = data["age"] as? NSNumber else { throw ReturnError.invalidJson }
            age = old.intValue
            guard let weights = data["weight"] as? NSNumber else { throw ReturnError.invalidJson }
            weight = weights.doubleValue
            guard let heights = data["height"] as? NSNumber else { throw ReturnError.invalidJson }
            height = heights.doubleValue
            hair_color = data["hair_color"] as? String
            guard let profArray = data["professions"] as? [String] else { throw ReturnError.invalidJson }
            professions = profArray
            guard let friendsArray = data["friends"] as? [String] else { throw ReturnError.invalidJson }
            friends = friendsArray
            
        } catch let error {
            throw error
        }
    }
}

extension Gnome : Equatable {
    static func ==(lhs: Gnome, rhs: Gnome) -> Bool {
        return lhs.id == rhs.id
    }
    
    
}
