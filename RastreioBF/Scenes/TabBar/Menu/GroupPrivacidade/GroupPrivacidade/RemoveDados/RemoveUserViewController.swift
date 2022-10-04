//
//  MeusDadosVC.swift
//  BackFrontProject
//
//  Created by ALYSSON MENEZES on 25/08/22.
//

import UIKit

class RemoveUserViewController: UIViewController, RemoveUserViewProtocol {
    
    var removeUserScreen: RemoveUserView?
    var alert : Alert?
    
    override func loadView() {
        self.removeUserScreen = RemoveUserView()
        self.view = self.removeUserScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.removeUserScreen?.delegate(delegate: self)
        self.alert = Alert(controller: self)
    }
    
    func actionRegisterButton() {
        guard self.removeUserScreen != nil else { return }
        var emailtTextfield = self.removeUserScreen?.emailAlertTextField
        self.alert?.deleteDataUser()
        
    }
}
