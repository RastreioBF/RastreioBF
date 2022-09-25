//
//  PrivacyPolicyVC.swift
//  BackFrontProject
//
//  Created by ALYSSON MENEZES on 29/08/22.
//

import UIKit

class PrivacidadeVC: UIViewController {
    let privacidadeScreen = PrivacidadeScreen()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = self.privacidadeScreen
        
    }
}
