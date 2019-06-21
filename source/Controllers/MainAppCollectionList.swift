//
//  MainAppCollectionList.swift
//  PruebaTecnicaTech
//
//  Created by andres on 6/20/19.
//  Copyright © 2019 Andres Paladines. All rights reserved.
//

import UIKit
import PKHUD
import Alamofire

private let listReuseIdentifier = "ListCell"

class MainAppCollectionList: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView   : UICollectionView!
    @IBOutlet weak var appeIageView     : UIImageView!
    @IBOutlet weak var itunesBtn        : UIButton!
    @IBOutlet weak var copyrightLabel   : UILabel!
    @IBOutlet weak var headerView       : UIView!
    
    @IBAction func itunesAction(_ sender: UIButton) {
        WebHelper.open(url: self.feed.links[1].value)
    }
    
    private var feed    : Feed! = nil
    var shownIndexes    : [IndexPath] = []
    let CELL_HEIGHT     : CGFloat = 40
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getFeed()
        setupCollectionView()
        setUpHeaderShadow()
        setupLayout(with: view.bounds.size)
        itunesBtn.isHidden = true
        itunesBtn.layer.cornerRadius = 2
        setNavController()
        appeIageView.layer.cornerRadius = appeIageView.bounds.size.height / 2
        appeIageView.backgroundColor = .white
    }
    
    //Este evento se activa al momento de rotar la pantalla para redimensionar la colección.
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        setupLayout(with: size)
    }
    
    //Se agrega el archivo .xib como tipo de celda a funcionar en la colección.
    private func setupCollectionView() {
        collectionView.register(UINib(nibName: "AppLayoutListCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: listReuseIdentifier)
    }
    
    //Este evento entra en accion despues del ViewDidLoad.
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        setupLayout(with: view.bounds.size)
    }
    
    //Configuramos los margenes por sección y las dimensiones de las celdas de acuerdo al tamaño de la pantalla.
    private func setupLayout(with containerSize: CGSize) {
        guard let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else {
            return
        }
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.minimumLineSpacing = 0
        flowLayout.sectionInset = UIEdgeInsets(top: 8.0, left: 0, bottom: 8.0, right: 0)
        
        if traitCollection.horizontalSizeClass == .regular {
            let minItemWidth: CGFloat = 250
            let numberOfCell = containerSize.width / minItemWidth
            //floor elimina el decimal y toma el numero entero menor. Ej: {2.3 = 3}, {2.8 = 2}
            let width = floor((numberOfCell / floor(numberOfCell)) * minItemWidth)
            flowLayout.itemSize = CGSize(width: width, height: 91)
        } else {
            flowLayout.itemSize = CGSize(width: containerSize.width, height: 91)
        }
        // independientemente del ancho de la pantalla, la altura de las celdas no varía a diferencia de su longitud horizontal
        collectionView.reloadData()
    }
    
    func setUpHeaderShadow() {
        headerView.layer.masksToBounds = false
        headerView.layer.shadowColor = UIColor.black.cgColor
        headerView.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        headerView.layer.shadowOpacity = 0.3
        headerView.layer.shadowRadius = 5
    }
    
    func setNavController() {
        let color = UIColor(red: 0/255, green: 102/255, blue: 98/255, alpha: 1)
        self.navigationController?.navigationBar.barTintColor           = color
        self.navigationController?.navigationBar.tintColor              = color
        self.navigationController?.navigationBar.titleTextAttributes    = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
}

extension MainAppCollectionList {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let feed = feed {
            return feed.results.count
        }else {
            return 0
        }
    }
    
    //Genera la animacion al momento de aparecer las celdas
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if (shownIndexes.contains(indexPath) == false) {
            shownIndexes.append(indexPath)
            
            cell.transform = CGAffineTransform(translationX: 0, y: CELL_HEIGHT)
            cell.layer.shadowColor = UIColor.black.cgColor
            cell.layer.shadowOffset = CGSize(width: 10, height: 10)
            cell.alpha = 0
            
            UIView.beginAnimations("rotation", context: nil)
            UIView.setAnimationDuration(0.3)
            cell.transform = CGAffineTransform(translationX: 0, y: 0)
            cell.alpha = 1
            cell.layer.shadowOffset = CGSize(width: 0, height: 0)
            UIView.commitAnimations()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: listReuseIdentifier, for: indexPath) as! AppLayoutListCollectionViewCell
        if let feed = self.feed {
            let app = feed.results[indexPath.item]
            cell.app = app
        }else {
            print("No se pudo renderizar celda #\(indexPath.item). feed status ☠️")
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let feed = self.feed else {
            return
        }
        let app = feed.results[indexPath.item]
        self.performSegue(withIdentifier: "goToDetails", sender: app)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "goToDetails":
            guard let destination = segue.destination as? DetailsAppViewController else {
                print("No se identifica destino")
                return
            }
            let app = sender as! App
            destination.artistName      = app.artistName
            destination.releaseDate     = app.releaseDate
            destination.name            = app.name
            destination.copyright       = app.copyright
            destination.artistUrl       = app.artistUrl
            destination.genres          = app.genres
            destination.url             = app.url
            destination.artworkUrl100   = app.artworkUrl100
        default:
            print("No existen segues para este identificador.")
        }
    }
    
}

extension MainAppCollectionList {
    
    func getFeed() {
        let atension = "Atención"
        let menssage = "No se pudo obtener datos desde el servidr."
        if !ReachabilityHelper.hasInternet() {
            AlertHelper.mostrar(view: self, titulo: atension, mensaje: menssage)
            return
        }
        let url = "https://rss.itunes.apple.com/api/v1/us/ios-apps/top-free/all/25/explicit.json"
        HUD.show(.label("Cargando apps..."))
        Alamofire.request(url, method: .get, encoding: JSONEncoding.default).responseJSON {
            response in
            DispatchQueue.main.async {
                HUD.hide()
                let statusCode  = response.response?.statusCode ?? 777
                
                switch response.result {
                case .success:
                    if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                        let json = JSON(data: (utf8Text.data(using: .utf8)!))
                        let titulo      = json["noticias"]["titulo"].string ?? atension
                        let mensaje     = json["noticias"]["mensaje"].string ?? menssage
                        
                        if(statusCode >= HttpStatus.ok && statusCode < HttpStatus.badRequest) {
                            let feed    = json["feed"]
                            if feed.count <= 0 {
                                AlertHelper.mostrar(view: self, titulo: titulo, mensaje: mensaje)
                                return
                            }
                            self.feed = Feed()
                            self.feed.setDataWith(json: feed)
                            self.setView()
                            self.collectionView.reloadData()
                        }else {
                            AlertHelper.mostrar(view: self, titulo: titulo, mensaje: mensaje)
                            //self.refrescar.endRefreshing()
                            return
                        }
                    }
                    break
                case .failure:
                    AlertHelper.mostrar(view: self, titulo: atension, mensaje: menssage)
                    break
                }
            }
        }
    }
    
    func setView() {
        navigationItem.title = self.feed.title
        appeIageView.sd_setImage(with: URL(string: self.feed.icon), placeholderImage: UIImage(named: ""))
        copyrightLabel.text = self.feed.copyright
        itunesBtn.isHidden = false
    }
    
}
