//
//  CadastroVC.swift
//  BackFrontProject
//
//  Created by ALYSSON MENEZES on 25/08/22.
//


import UIKit

class RegistrationViewController: UIViewController {

    var cadastro : RegistrationView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func loadView() {
        self.cadastro = RegistrationView()
        super.viewDidLoad()
        self.view = self.cadastro
    }
    

}
