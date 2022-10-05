//
//  PrivacyPolicyVC.swift
//  BackFrontProject
//
//  Created by ALYSSON MENEZES on 29/08/22.
//

import UIKit

class PrivacyPoliciesViewController: UIViewController, PrivacyPoliciesViewProtocol {
    
    var privacyView : PrivacyPoliciesView?

    func actionBackButton() {
        self.navigationController?.popViewController(animated: true)
        print("tappedButton")
    }
    
    override func loadView() {
        privacyView = PrivacyPoliciesView()
        self.view = self.privacyView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
     
        self.privacyView?.delegate(delegate: self)
    }
}
