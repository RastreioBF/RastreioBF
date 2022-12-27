//
//  Alert.swift
//  RastreioBF
//
//  Created by Jessica Bigal on 09/09/22.
//

import Foundation
import UIKit
import FirebaseAuth

enum TypeStateSelected {
    case onWay
    case pendencie
    case done
    case all
    case cancel
}

class Alert:NSObject {
    
    var controller:UIViewController
    
    init(controller:UIViewController) {
        self.controller = controller
    }
    
    func getAlert(titulo:String, mensagem:String, completion:(() -> Void)? = nil){
        let alertController = UIAlertController(title: titulo, message: mensagem, preferredStyle: .alert)
        let action = UIAlertAction(title: LC.okButton.text, style: .cancel) { acao in
            completion?()
        }
        alertController.addAction(action)
        self.controller.present(alertController, animated: true, completion: nil)
    }
    
    func getAlertActions(titulo:String, mensagem:String, completion:(() -> Void)? = nil){
        let alertController = UIAlertController(title: titulo, message: mensagem, preferredStyle: .alert)
        let action = UIAlertAction(title: LC.okButton.text, style: .default) { acao in
            completion?()
        }
        let cancel = UIAlertAction(title: LC.calcelButton.text, style: .default, handler: nil)
        alertController.addAction(action)
        alertController.addAction(cancel)
        self.controller.present(alertController, animated: true, completion: nil)
    }
    
    func filterState(completion: @escaping (_ option: TypeStateSelected) -> Void) {
        let alertController: UIAlertController = UIAlertController(title: nil , message: nil, preferredStyle: .actionSheet)
        
        let pendencies = UIAlertAction(title: LC.pendenciesFilter.text, style: .default) { action in
            completion(.pendencie)
        }
        
        let onItsWay = UIAlertAction(title: LC.onItsWayFilter.text, style: .default) { action in
            completion(.onWay)
        }
        
        let delivered = UIAlertAction(title: LC.deliveredFilter.text, style: .default) { action in
            completion(.done)
        }
        
        let all = UIAlertAction(title: LC.allFilter.text, style: .default) { action in
            completion(.all)
        }
        
        let cancel = UIAlertAction(title: LC.calcelButton.text, style: .cancel) { action in
            completion(.cancel)
        }
        
        alertController.addAction(onItsWay)
        alertController.addAction(delivered)
        alertController.addAction(pendencies)
        alertController.addAction(all)
        alertController.addAction(cancel)
        controller.present(alertController, animated: true)
    }
}
