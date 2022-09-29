//
//  PrivacyPolicyVC.swift
//  BackFrontProject
//
//  Created by ALYSSON MENEZES on 29/08/22.
//

import UIKit

class PrivacidadeVC: UIViewController, PrivacidadeScreenProtocol {
    
    var privacidadeScreen : PrivacidadeScreen?

    func actionBackButton() {
        self.navigationController?.popViewController(animated: true)
        print("tappedButton")
    }
    
    override func loadView() {
        privacidadeScreen = PrivacidadeScreen()
        self.view = self.privacidadeScreen
    }
    override func viewDidLoad() {
        super.viewDidLoad()
     
        self.privacidadeScreen?.delegate(delegate: self)
    }
}
