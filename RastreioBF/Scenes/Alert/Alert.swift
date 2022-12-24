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
        let action = UIAlertAction(title: "OK", style: .cancel) { acao in
            completion?()
        }
        alertController.addAction(action)
        self.controller.present(alertController, animated: true, completion: nil)
    }
    
    func getAlertActions(titulo:String, mensagem:String, completion:(() -> Void)? = nil){
        let alertController = UIAlertController(title: titulo, message: mensagem, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default) { acao in
            completion?()
        }
        let cancel = UIAlertAction(title: "Cancelar", style: .default, handler: nil)
        alertController.addAction(action)
        alertController.addAction(cancel)
        self.controller.present(alertController, animated: true, completion: nil)
    }
    
    func addContact(completion:((_ value:String) -> Void)? = nil){
        var _textField:UITextField?
        let alert = UIAlertController(title: "Solicitar dados", message: "Em qual endereço de e-mail você deseja receber o relatório dos seus dados?", preferredStyle: .alert)
        let ok = UIAlertAction(title: "enviar", style: .default) { (acao) in
            completion?(_textField?.text ?? "")
        }
        let cancel = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        alert.addAction(cancel)
        alert.addAction(ok)
        alert.addTextField(configurationHandler: {(textField: UITextField) in
            _textField = textField
            textField.placeholder = "Email:"
        })
        self.controller.present(alert, animated: true, completion: nil)
    }
    
    func deleteDataUser(completion:((_ value:String) -> Void)? = nil){
        var _textField:UITextField?
        let alert = UIAlertController(title: "Remover Dados", message: "Essa opção irá apagar todos os seus dados (rastreios, conta de login, desse e dos demais dispositivos que você fez login com a sua conta (caso tenha feito), e também os apagará do servidor. Os dados serão removidos permanentemente sem opção de backup. Deseja prosseguir?", preferredStyle: .alert)
        let ok = UIAlertAction(title: "enviar", style: .default) { (acao) in
            completion?(_textField?.text ?? "")
            let user = Auth.auth().currentUser
            user?.delete { error in
                if let error = error {
                    // An error happened.
                } else {
                    let vc:LoginViewController = LoginViewController()
                    self.controller.navigationController?.pushViewController(vc, animated: false)
                }
            }
        }
        let cancel = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        alert.addAction(cancel)
        alert.addAction(ok)
        self.controller.present(alert, animated: true, completion: nil)
    }
    
    
    
    func userAlertLogout(completion:((_ value:String) -> Void)? = nil){
        var _textField:UITextField?
        let alert = UIAlertController(title: "Atenção", message: "Deseja sair ?", preferredStyle: .alert)
        let ok = UIAlertAction(title: "continuar", style: .default) { (acao) in
            completion?(_textField?.text ?? "")
//
            let vc:LoginViewController = LoginViewController()
            self.controller.navigationController?.pushViewController(vc, animated: false)
        }
        let cancel = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        alert.addAction(cancel)
        alert.addAction(ok)
        self.controller.present(alert, animated: true, completion: nil)
    }
    
    func filterState(completion: @escaping (_ option: TypeStateSelected) -> Void) {
        let alertController: UIAlertController = UIAlertController(title: "Filtro", message: nil, preferredStyle: .actionSheet)
        
        let pendencies = UIAlertAction(title: "Pendencias", style: .default) { action in
            completion(.pendencie)
        }
        
        let onItsWay = UIAlertAction(title: "Em Rota", style: .default) { action in
            completion(.onWay)
        }
        
        let delivered = UIAlertAction(title: "Entregue", style: .default) { action in
            completion(.done)
        }
        
        let all = UIAlertAction(title: "Todos", style: .default) { action in
            completion(.done)
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { action in
            completion(.cancel)
        }
        
        alertController.addAction(pendencies)
        alertController.addAction(onItsWay)
        alertController.addAction(delivered)
        alertController.addAction(all)
        alertController.addAction(cancel)
        controller.present(alertController, animated: true)
    }
}
