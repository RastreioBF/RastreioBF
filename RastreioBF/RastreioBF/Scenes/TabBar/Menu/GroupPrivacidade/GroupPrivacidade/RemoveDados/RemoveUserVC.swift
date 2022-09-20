//
//  MeusDadosVC.swift
//  BackFrontProject
//
//  Created by ALYSSON MENEZES on 25/08/22.
//

import UIKit

class RemoveUserVC: UIViewController, RemoveUserScreenProtocol {
   
    
 
    var removeUserScreen: RemoveUserScreen?
    var alert : Alert?
    
    
    override func loadView() {
        self.removeUserScreen = RemoveUserScreen()
        self.view = self.removeUserScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.removeUserScreen?.delegate(delegate: self)
        self.alert = Alert(controller: self)
}
    
    
    func actionRegisterButton() {
        guard let register = self.removeUserScreen else { return }
        var emailtTextfield = self.removeUserScreen?.emailAlertTextField
        self.alert?.getAlert(titulo: "ATENÇÃO", mensagem: " Essa opção irá apagar todos os seus dados (rastreios, conta de login, sincronização, entre outros) desse e dos demais dispositivos que você fez login com a sua conta (caso tenha feito), e também os apagará do servidor. Os dados serão removidos permanentemente sem opção debackup. Deseja prosseguir?")
        
    }
    
}


