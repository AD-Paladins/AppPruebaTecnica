//
//  Feed.swift
//  PruebaTecnicaTech
//
//  Created by andres on 6/20/19.
//  Copyright © 2019 Andres Paladines. All rights reserved.
//

import Foundation
import Alamofire

class Feed {
    var title   : String!
    var id      : String!
    var author  : Author!
    var links   : [Link]!
    var copyright: String!
    var country : String!
    var icon    : String!
    var updated : String!
    var results : [App]!
    
    func setDataWith(json: JSON) {
        self.title       = json["title"].string ?? ""
        self.id          = json["id"].string ?? ""
        self.author      = Author(json: json["author"])
        self.links       = setLinks(json: json["links"])
        self.copyright   = json["copyright"].string ?? ""
        self.country     = json["country"].string ?? ""
        self.icon        = json["icon"].string ?? ""
        self.updated     = json["updated"].string ?? ""
        self.results     = setApps(json: json["results"])
    }
    
}

extension Feed {
    
    private func setLinks(json: JSON) -> [Link] {
        var links : [Link] = []
        
        if let selfString = json[0]["self"].string {
            links.append(Link(name: "self", value: selfString))
        }
        
        if let alternateString = json[1]["alternate"].string {
            links.append(Link(name: "alternate", value: alternateString))
        }
        
        return links
    }
    
    private func setApps(json: JSON) -> [App] {
        var apps : [App] = []
        let count = json.count - 1
        if count < 0 {
            return apps
        }
        
        for index in 0...count {
            let data = json[index]
            let app = App()
            app.setDataWith(json: data)
            apps.append(app)
        }
        
        return apps
    }
}
