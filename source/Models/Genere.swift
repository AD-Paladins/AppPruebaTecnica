//
//  Genere.swift
//  PruebaTecnicaTech
//
//  Created by andres on 6/20/19.
//  Copyright © 2019 Andres Paladines. All rights reserved.
//

import Foundation

class Genere {
    var genreId: String!
    var name    : String!
    var url     : String!
    
    init(json: JSON) {
        self.genreId   = json["genreId"].string ?? ""
        self.name       = json["name"].string ?? ""
        self.url        = json["url"].string ?? ""
    }
    
}
