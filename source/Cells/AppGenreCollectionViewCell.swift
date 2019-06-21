//
//  AppGenreTableViewCell.swift
//  PruebaTecnicaTech
//
//  Created by andres on 6/20/19.
//  Copyright © 2019 Andres Paladines. All rights reserved.
//

import UIKit
import SDWebImage

class AppGenreCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var genreView: UIView!
    @IBOutlet var genreLabel: UILabel!
    
    var genre: Genere? {
        didSet {
            if let genre = genre {
//                genreView.cornerRadius = 2
                genreLabel.textAlignment = .center
                genreLabel.text = genre.name
            }
        }
    }
    
}
