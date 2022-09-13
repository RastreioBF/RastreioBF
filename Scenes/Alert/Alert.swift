//
//  Alert.swift
//  RastreioBF
//
//  Created by Jessica Bigal on 09/09/22.
//

import Foundation
import UIKit

class Alert:NSObject{
    
    //Precisamos da controller para que seja chamada para aparecer o alert
    var controller:UIViewController
    
    init(controller:UIViewController) {
        self.controller = controller
    }
    
    //completion sera optional, que refere ao botao, se quero ou nao ter alguma acao
    
    func getAlert(titulo:String, mensagem:String, completion:(() -> Void)? = nil){
        
        // preferredStyle: eh como prefiro setar o alerta, como actiomsheet (aparece na parte inferior da tela) ou alert
        let alertController = UIAlertController(title: titulo, message: mensagem, preferredStyle: .alert)
        //botao que aparece no alert, de forma opcional
        let cancelar = UIAlertAction(title: "OK", style: .cancel) { acao in
            completion?()
        }
        alertController.addAction(cancelar)
        self.controller.present(alertController, animated: true, completion: nil)
    }
}
