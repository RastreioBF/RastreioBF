//
//  MeusDadosVC.swift
//  BackFrontProject
//
//  Created by ALYSSON MENEZES on 25/08/22.
//

import UIKit

class RemoveUserVC: UIViewController, RemoveUserScreenProtocol {
    func actionBackButton() {
        self.navigationController?.popViewController(animated: true)
    }
    
    var removeUserScreen: RemoveUserScreen?
    var alert : Alert?
    
    override func loadView() {
        self.removeUserScreen = RemoveUserScreen()
        self.view = self.removeUserScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.removeUserScreen?.delegate(delegate: self)
        self.alert = Alert(controller: self)
    }
    
    func actionRegisterButton() {
        guard let register = self.removeUserScreen else { return }
        self.alert?.deleteDataUser()
        
    }
}
