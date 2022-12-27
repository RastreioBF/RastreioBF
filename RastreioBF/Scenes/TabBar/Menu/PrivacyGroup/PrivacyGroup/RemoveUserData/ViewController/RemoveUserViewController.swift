//
//  MeusDadosVC.swift
//  BackFrontProject
//  Created by ALYSSON MENEZES on 25/08/22.
//

import UIKit

class RemoveUserViewController: UIViewController {
    
    private var removeUserScreen: RemoveUserView?
    private var alert: Alert?
    
    override func loadView() {
        removeUserScreen = RemoveUserView()
        view = removeUserScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        removeUserScreen?.delegate(delegate: self)
        alert = Alert(controller: self)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        hidesBottomBarWhenPushed = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
       
    func actionRegisterButton() {
        guard removeUserScreen != nil else { return }
        alert?.deleteDataUser()
    }
}

extension RemoveUserViewController: RemoveUserScreenProtocol {
    func actionBackButton() {
        navigationController?.popViewController(animated: true)
    }
}
