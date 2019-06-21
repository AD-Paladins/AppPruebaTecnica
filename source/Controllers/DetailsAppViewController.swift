//
//  DetailsApp.swift
//  PruebaTecnicaTech
//
//  Created by andres on 6/20/19.
//  Copyright © 2019 Andres Paladines. All rights reserved.
//

import UIKit
import SDWebImage

private let listReuseIdentifier = "ListCell"

class DetailsAppViewController : UIViewController {
    
    @IBOutlet weak var nameApp          : UILabel!
    @IBOutlet weak var artistAppBtn     : UIButton!
    @IBOutlet weak var iconApp          : UIImageView!
    @IBOutlet weak var iconAppShadow    : UIView!
    @IBOutlet weak var bottomView       : UIView!
    @IBOutlet weak var bottomViewContainer  : UIView!
    @IBOutlet weak var shareBtn         : UIButton!
    @IBOutlet weak var goToItunesBtn    : UIButton!
    @IBOutlet weak var collectionView   : UICollectionView!
    
    @IBOutlet weak var lauchDateLabel: UILabel!
    @IBOutlet weak var copyrightLabel: UILabel!
    
    @IBOutlet weak var launchBtn: UIView!
    @IBOutlet weak var copyrightBtn: UIView!
    
    @IBAction func shareAction(_ sender: UIButton) {
        shareApp()
    }
    
    @IBAction func artistAppAction(_ sender: UIButton) {
        WebHelper.open(url: artistUrl)
    }
    
    @IBAction func goToItunesAction(_ sender: UIButton) {
        WebHelper.open(url: url)
    }
    
    
    var artistName      : String!
    var releaseDate     : String!
    var name            : String!
    var copyright       : String!
    var artistUrl       : String!
    var genres          : [Genere]!
    var url             : String!
    var artworkUrl100   : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Detalles de app"
        setupCollectionView()
        setNavController()
        setIconApp()
        setBottomView()
        setItunesBtn()
        
        
        artistAppBtn.setTitle(artistName, for: .normal)
        artistAppBtn.titleLabel?.adjustsFontSizeToFitWidth = true
        
        goToItunesBtn.titleLabel?.adjustsFontSizeToFitWidth = true
        
        lauchDateLabel.text = releaseDate
        copyrightLabel.text = copyright
        nameApp.text = name
        nameApp.font = UIFont.systemFont(ofSize: 35, weight: UIFont.Weight(rawValue: 400))
        nameApp.fitTextToBounds()
        
        hideLargeButtons()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        animateLargeButtons()
    }
    
    //Se agrega el archivo .xib como tipo de celda a funcionar en la colección.
    private func setupCollectionView() {
        collectionView.register(UINib(nibName: "AppGenreCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: listReuseIdentifier)
    }
    
    func setNavController() {
        let color = UIColor(red: 0/255, green: 102/255, blue: 98/255, alpha: 1)
        self.navigationController?.navigationBar.barTintColor           = color
        self.navigationController?.navigationBar.tintColor              = color
        self.navigationController?.navigationBar.titleTextAttributes    = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
    
    func setIconApp() {
        iconApp.sd_setImage(with: URL(string: artworkUrl100), placeholderImage: UIImage(named: "app_placeholder"))
        let bounds = iconApp.bounds
        let radius = bounds.size.height * 0.15
        let shadowOffsetWidth = 0
        let shadowOffsetHeight = 1
        let shadowOpacity = Float(0.3)
        
        iconApp.layer.cornerRadius = radius
        iconApp.backgroundColor = .clear
        
        iconAppShadow.layer.cornerRadius = radius
        iconAppShadow.layer.masksToBounds = false
        iconAppShadow.layer.shadowColor = UIColor.black.cgColor
        iconAppShadow.layer.shadowOffset = CGSize(width: shadowOffsetWidth, height: shadowOffsetHeight);
        iconAppShadow.layer.shadowOpacity = shadowOpacity
//        iconAppShadow.layer.shadowPath = shadowPath.cgPath
        iconAppShadow.layer.shadowRadius = 5
        
    }
    
    func setBottomView() {
        bottomViewContainer.backgroundColor = .clear
        bottomView.backgroundColor = .clear
        
        bottomViewContainer.layer.cornerRadius = 15
        bottomViewContainer.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]

        bottomView.layer.cornerRadius = 15
        bottomView.layer.masksToBounds = false
        bottomView.layer.shadowColor = UIColor.black.cgColor
        bottomView.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        bottomView.layer.shadowOpacity = 0.3
        bottomView.layer.shadowRadius = 5
        
        bottomView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        let backgroundLayer = Colors().gl
        backgroundLayer.frame = bottomViewContainer.frame
        bottomViewContainer.layer.insertSublayer(backgroundLayer, at: 0)
        bottomView.layer.insertSublayer(backgroundLayer, at: 0)
    }
    
    func setItunesBtn() {
        goToItunesBtn.layer.cornerRadius = 4
    }
    
    func shareApp() {
        guard let text = url else {
            print("No url available...")
            return
        }
        let textToShare = [ text ]
        let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        
        activityViewController.excludedActivityTypes = [
            UIActivity.ActivityType.airDrop,
            UIActivity.ActivityType.postToFacebook
        ]
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    func hideLargeButtons() {
        launchBtn.transform = CGAffineTransform(translationX: 0, y: 45)
        launchBtn.layer.shadowColor = UIColor.black.cgColor
        launchBtn.layer.shadowOffset = CGSize(width: 10, height: 10)
        launchBtn.alpha = 0
        
        copyrightBtn.transform = CGAffineTransform(translationX: 0, y: 45)
        copyrightBtn.layer.shadowColor = UIColor.black.cgColor
        copyrightBtn.layer.shadowOffset = CGSize(width: 10, height: 10)
        copyrightBtn.alpha = 0
    }
    func animateLargeButtons() {
        
        
        UIView.beginAnimations("rotation", context: nil)
        UIView.setAnimationDuration(0.3)
        launchBtn.transform = CGAffineTransform(translationX: 0, y: 0)
        launchBtn.alpha = 1
        launchBtn.layer.shadowOffset = CGSize(width: 0, height: 0)
        UIView.commitAnimations()
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + DispatchTimeInterval.milliseconds(150)) {
            UIView.beginAnimations("rotation", context: nil)
            UIView.setAnimationDuration(0.3)
            self.copyrightBtn.transform = CGAffineTransform(translationX: 0, y: 0)
            self.copyrightBtn.alpha = 1
            self.copyrightBtn.layer.shadowOffset = CGSize(width: 0, height: 0)
        }
        
        
        
        
    }
    
}

extension DetailsAppViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let label = UILabel(frame: CGRect.zero)
        label.text = self.genres[indexPath.item].name
        label.font = UIFont.systemFont(ofSize: 25, weight: UIFont.Weight(rawValue: 400))
        label.sizeToFit()
        return CGSize(width: label.frame.width, height: collectionView.bounds.height/2)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return genres.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: listReuseIdentifier, for: indexPath) as! AppGenreCollectionViewCell
        cell.genre = self.genres[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let genre = self.genres[indexPath.item]
        WebHelper.open(url: genre.url)
    }
    
}
