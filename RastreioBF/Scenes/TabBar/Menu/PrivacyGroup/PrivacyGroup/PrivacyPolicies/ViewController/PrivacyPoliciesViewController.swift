//
//  PrivacyPolicyVC.swift
//  BackFrontProject
//
//  Created by ALYSSON MENEZES on 29/08/22.
//

import UIKit

class PrivacyPoliciesViewController: UIViewController {
    
    private var privacyView: PrivacyPoliciesView?
    private var privacyVM = PrivacyViewModel()
    
    override func loadView() {
        privacyView = PrivacyPoliciesView()
        view = privacyView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configPrivacyView()
    }
    
    private func configPrivacyView(){
        privacyView?.delegate(delegate: self)
        privacyView?.privacyLabel.text = privacyVM.getPrivacyPolicy()
        privacyView?.loginLabel.text = privacyVM.getTitle()
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        hidesBottomBarWhenPushed = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PrivacyPoliciesViewController: PrivacyPoliciesViewProtocol {
    func actionBackButton() {
        self.navigationController?.popViewController(animated: true)
    }
}
