//
//  Author.swift
//  PruebaTecnicaTech
//
//  Created by andres on 6/20/19.
//  Copyright © 2019 Andres Paladines. All rights reserved.
//

import Foundation

struct Author {
    let name    : String
    let uri     : String
}

extension Author {
    
    init(json: JSON) {
        self = Author(
            name: json["name"].string ?? "",
            uri : json["uri"].string ?? ""
        )
    }
}
