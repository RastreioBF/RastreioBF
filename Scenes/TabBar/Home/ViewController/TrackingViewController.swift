//
//  HomeViewController.swift
//  RastreioBF
//
//  Created by Jessica Bigal on 09/09/22.
//

import UIKit
import UIKit

class TrackingViewController: UIViewController {
    
    var trackingScreen: TrackingScreen?
    var alert: Alert?
    
    override func loadView() {
        self.trackingScreen = TrackingScreen()
        self.view = self.trackingScreen
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.navigationItem.title = LC.homeTitle.text
        self.navigationItem.titleView?.tintColor = .systemBlue
        self.trackingScreen?.configTextFieldDelegate(delegate: self)
        self.trackingScreen?.delegate(delegate: self)
        self.alert = Alert(controller: self)
    }
}

extension TrackingViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.trackingScreen?.validateTextFields()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension TrackingViewController: TrackingScreenProtocol{
    func actionEmailNotificationSwitch() {
    }
    
    func actionSendNoticationToAnotherEmailButton() {
        let viewController = EmailNotificationViewController()
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func actionSubmitButton() {
        
        self.alert?.getAlert(titulo: "Dados Salvos", mensagem: "Seus dados de rastreio foram salvos com sucesso!")
        self.trackingScreen?.trackingNumberTextField.text = ""
        self.trackingScreen?.descriptionTextField.text = ""
    }
    
    func actionBackButton() {
        let viewController = LoginViewController()
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}
