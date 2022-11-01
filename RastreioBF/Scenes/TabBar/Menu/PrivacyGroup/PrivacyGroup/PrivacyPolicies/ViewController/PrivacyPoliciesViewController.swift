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
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
                super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
                hidesBottomBarWhenPushed = true
            }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }


}
