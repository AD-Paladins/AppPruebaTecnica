//
//  MovieListCollectionViewCell.swift
//  CollectionViewResponsiveLayout
//
//  Created by Andres Paladines on 2/8/19.
//  Copyright © 2019 Andres Paladines. All rights reserved.
//

import UIKit
import SDWebImage

class AppLayoutListCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieDescriptionLabel: UILabel!
    
    var app: App? {
        didSet {
            if let app = app {
                posterImageView.sd_setImage(with: URL(string: app.artworkUrl100), placeholderImage: UIImage(named: "app_placeholder"))
                posterImageView.layer.cornerRadius = 15
                movieTitleLabel.text = app.name
                movieDescriptionLabel.text = app.artistName
            }
        }
    }

}
