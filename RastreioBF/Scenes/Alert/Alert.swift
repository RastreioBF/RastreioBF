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
            
            let vc:LoginViewController = LoginViewController()
            self.controller.navigationController?.pushViewController(vc, animated: false)
        }
        let cancel = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        alert.addAction(cancel)
        alert.addAction(ok)
        self.controller.present(alert, animated: true, completion: nil)
    }
}
