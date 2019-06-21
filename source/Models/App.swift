//
//  App.swift
//  PruebaTecnicaTech
//
//  Created by andres on 6/20/19.
//  Copyright © 2019 Andres Paladines. All rights reserved.
//

import Foundation

class App {
    var artistName      : String!
    var id              : String!
    var releaseDate     : String!
    var name            : String!
    var kind            : String!
    var copyright       : String!
    var artistId        : String!
    var artistUrl       : String!
    var artworkUrl100   : String!
    var genres          : [Genere]!
    var url             : String!
    
    func setDataWith(json: JSON) {
        self.artistName      = json["artistName"].string ?? ""
        self.id              = json["id"].string ?? ""
        self.releaseDate     = json["releaseDate"].string ?? ""
        self.name            = json["name"].string ?? ""
        self.kind            = json["kind"].string ?? ""
        self.copyright       = json["copyright"].string ?? ""
        self.artistId        = json["artistId"].string ?? ""
        self.artistUrl       = json["artistUrl"].string ?? ""
        self.artworkUrl100   = json["artworkUrl100"].string ?? ""
        self.genres          = getGeneres(json: json["genres"])
        self.url             = json["url"].string ?? ""
    }
}

extension App {
    
    private func getGeneres(json: JSON) -> [Genere] {
        var generes : [Genere] = []
        let count = json.count - 1
        if count < 0 {
            return generes
        }
        for index in 0...count {
            let gen = Genere(json: json[index])
            generes.append(gen)
        }
        return generes
    }
}
