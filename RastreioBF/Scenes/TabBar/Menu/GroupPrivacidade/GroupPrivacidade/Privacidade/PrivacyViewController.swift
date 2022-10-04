//
//  PrivacyPolicyVC.swift
//  BackFrontProject
//
//  Created by ALYSSON MENEZES on 29/08/22.
//

import UIKit

class PrivacyViewController: UIViewController {
    let privacidadeScreen = PrivacyView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = self.privacidadeScreen
        
    }
}
