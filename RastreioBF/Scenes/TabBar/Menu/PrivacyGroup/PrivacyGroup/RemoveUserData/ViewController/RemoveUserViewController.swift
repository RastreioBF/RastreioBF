//
//  MeusDadosVC.swift
//  BackFrontProject
// teste
//  Created by ALYSSON MENEZES on 25/08/22.
//

import UIKit

class RemoveUserViewController: UIViewController, RemoveUserScreenProtocol {
    func actionBackButton() {
        self.navigationController?.popViewController(animated: true)
    }
    
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
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
                super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
                hidesBottomBarWhenPushed = true
            }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

    
    func actionRegisterButton() {
        guard let register = self.removeUserScreen else { return }
        self.alert?.deleteDataUser()
        
    }
}
