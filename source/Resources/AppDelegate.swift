//
//  AppDelegate.swift
//  CollectionViewResponsiveLayout
//
//  Created by Andres Paladines on 2/8/19.
//  Copyright © 2019 Andres Paladines. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setDarkTheme()
//        setLightTheme()
        return true
    }
    
    //MARK: - Temas incompletos para el collectionView
    private func setDarkTheme() {
        UINavigationBar.appearance().barTintColor = UIColor(red: 45/255, green: 45/255, blue: 45/255, alpha: 1.0)
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        UIBarButtonItem.appearance().tintColor = UIColor.white
    }
    
    private func setLightTheme() {
        UINavigationBar.appearance().barTintColor = UIColor(red: 255/255, green: 245/255, blue: 236/255, alpha: 1.0)
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.darkGray]
        UIBarButtonItem.appearance().tintColor = UIColor.darkGray
    }

}
