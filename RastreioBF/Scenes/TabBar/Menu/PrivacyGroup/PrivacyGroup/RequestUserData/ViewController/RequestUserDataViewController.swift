//
//  MeusDadosVC.swift
//  BackFrontProject
//
//  Created by ALYSSON MENEZES on 25/08/22.
//

import UIKit

class RequestUserDataViewController: UIViewController, RequestUserDataProtocol {
    func actionBackButton() {
        self.navigationController?.popViewController(animated: true)
    }
    
    var userDataView: RequestUserDataView?
    var alert : Alert?
    
    
    override func loadView() {
        self.userDataView = RequestUserDataView()
        self.view = self.userDataView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.userDataView?.delegate(delegate: self)
        self.alert = Alert(controller: self)
        
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
                super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
                hidesBottomBarWhenPushed = true
            }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }


    
    func actionRegisterButton() {
        guard let register = self.userDataView else { return }
        self.alert?.addContact()
    }
    
    
    
}
