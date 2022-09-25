//
//  CadastroVC.swift
//  BackFrontProject
//
//  Created by ALYSSON MENEZES on 25/08/22.
//


import UIKit

class CadastroVC: UIViewController {

    var cadastro : CadastroScreen?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func loadView() {
        self.cadastro = CadastroScreen()
        super.viewDidLoad()
        self.view = self.cadastro
    }
    

}
