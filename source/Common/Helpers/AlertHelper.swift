//
//  AlertHelper.swift
//  PruebaTecnicaTech
//
//  Created by andres on 6/20/19.
//  Copyright © 2019 Andres Paladines. All rights reserved.
//

import Foundation
import UIKit

class AlertHelper: NSObject {
    
    class func mostrar(view: UIViewController ,titulo: String , mensaje: String, botones:[UIAlertAction]? = nil, estiloAlerta: UIAlertController.Style? = nil ) {
        var estiloDeAlerta : UIAlertController.Style?
        if estiloAlerta == nil{
            estiloDeAlerta = .alert
        }else{
            estiloDeAlerta = estiloAlerta
        }
        let alert = UIAlertController(title: titulo, message: mensaje, preferredStyle: estiloDeAlerta!)
        
        if((botones) != nil) {
            for (key) in botones!
            {
                alert.addAction(key)
            }
        }else{
            alert.addAction(UIAlertAction(title: "Aceptar", style: UIAlertAction.Style.default, handler: nil))
        }
        
        DispatchQueue.main.async {
            view.present(alert, animated: true, completion: nil)
        }
    }
    
    
    static func listado(conTitulo:String, yMensaje:String,Acciones:[UIAlertAction] )-> UIAlertController{
        
        
        // Create the alert controller
        let alertController = UIAlertController(title: conTitulo, message: yMensaje, preferredStyle: .actionSheet)
        
        // Create the actions
        
        for accion in Acciones {
            // Add the actions
            alertController.addAction(accion)
        }
        
        return alertController
        //let  vc:UIViewController = (UIApplication.shared.delegate as! AppDelegate).window!.rootViewController!.presentedViewController!
        //vc.present(alertController, animated: false, completion: nil)
        
    }
    
}
