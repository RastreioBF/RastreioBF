//
//  MeusDadosVC.swift
//  BackFrontProject
//
//  Created by ALYSSON MENEZES on 25/08/22.
//

import UIKit

class RequestUserDataViewController: UIViewController {
    
    private var userDataView: RequestUserDataView?
    private var alert: Alert?

    override func loadView() {
        userDataView = RequestUserDataView()
        view = userDataView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userDataView?.delegate(delegate: self)
        alert = Alert(controller: self)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        hidesBottomBarWhenPushed = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    internal func actionRegisterButton() {
        guard userDataView != nil else { return }
        alert?.addContact()
    }
}

extension RequestUserDataViewController: RequestUserDataProtocol {
    func actionBackButton() {
        navigationController?.popViewController(animated: true)
    }
}
