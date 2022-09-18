//
//  EmailNotificationViewController.swift
//  RastreioBF
//
//  Created by Jessica Bigal on 11/09/22.
//

import UIKit

class EmailNotificationViewController: UIViewController {
    
    var emailNotificationScreen: EmailNotificationScreen?
    var alert: Alert?
    
    override func loadView() {
        self.emailNotificationScreen = EmailNotificationScreen()
        self.view = self.emailNotificationScreen
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.emailNotificationScreen?.configTextFieldDelegate(delegate: self)
        self.emailNotificationScreen?.delegate(delegate: self)
        self.alert = Alert(controller: self)

    }
}

extension EmailNotificationViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.emailNotificationScreen?.validateTextFields()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension EmailNotificationViewController: EmailNotificationScreenProtocol{
    func actionBackButton() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func actionConfirmationButton() {
        self.alert?.getAlert(titulo: "Tudo certo", mensagem: "Email cadastrado com sucesso!", completion: actionBackButton)
    }
}

