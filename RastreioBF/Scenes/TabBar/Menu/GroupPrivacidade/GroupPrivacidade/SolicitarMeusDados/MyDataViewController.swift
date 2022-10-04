//
//  MeusDadosVC.swift
//  BackFrontProject
//
//  Created by ALYSSON MENEZES on 25/08/22.
//

import UIKit

class MyDataViewController: UIViewController, MyDataViewProtocol {
   
    
 
    var meusDadosScreen: MyDataView?
    var alert : Alert?
    
    
    override func loadView() {
        self.meusDadosScreen = MyDataView()
        self.view = self.meusDadosScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.meusDadosScreen?.delegate(delegate: self)
        self.alert = Alert(controller: self)
}
    
    
    func actionRegisterButton() {
        guard let register = self.meusDadosScreen else { return }
        var emailtTextfield = self.meusDadosScreen?.emailAlertTextField
        //self.alert?.getAlert(titulo: "Solicitar dados", mensagem: " Em qual endereço de e-mail você deseja receber o relatório dos seus dados?" )
        self.alert?.addContact()
        
        
    }
    
}
