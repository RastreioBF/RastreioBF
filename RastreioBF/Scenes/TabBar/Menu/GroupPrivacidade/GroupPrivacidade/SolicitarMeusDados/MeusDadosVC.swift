//
//  MeusDadosVC.swift
//  BackFrontProject
//
//  Created by ALYSSON MENEZES on 25/08/22.
//

import UIKit

class MeusDadosVC: UIViewController, MeusDadosScreenProtocol {
    func actionBackButton() {
        self.navigationController?.popViewController(animated: true)
    }
    
    var meusDadosScreen: MeusDadosScreen?
    var alert : Alert?
    
    
    override func loadView() {
        self.meusDadosScreen = MeusDadosScreen()
        self.view = self.meusDadosScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.meusDadosScreen?.delegate(delegate: self)
        self.alert = Alert(controller: self)
        
    }
    func actionRegisterButton() {
        guard let register = self.meusDadosScreen else { return }
        self.alert?.addContact()
    }
    
    
    
}
