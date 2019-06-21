//
//  WebHelper.swift
//  PruebaTecnicaTech
//
//  Created by andres on 6/20/19.
//  Copyright © 2019 Andres Paladines. All rights reserved.
//

import Foundation
import UIKit

class WebHelper {
    
    static func open(url: String) {
        print(url)
        UIApplication.shared.open(URL(string: url)!, options: [:]) {
            bool in
            print( bool ? "opened" : "NOT opened")
        }
    }
}
