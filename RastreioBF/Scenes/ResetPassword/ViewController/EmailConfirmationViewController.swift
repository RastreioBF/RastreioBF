//
//  EmailConfirmationViewController.swift
//  RastreioBF
//
//  Created by Jessica Bigal on 09/09/22.
//

import UIKit
import FirebaseAuth

class EmailConfirmationViewController: UIViewController, EmailConfirmationScreenProtocol, UITextFieldDelegate {
    
    var auth:Auth?
    var emailConfirmationScreen:EmailConfirmationScreen?
    var alert:Alert?
    
    override func loadView() {
        self.emailConfirmationScreen = EmailConfirmationScreen()
        self.view = self.emailConfirmationScreen
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.emailConfirmationScreen?.delegate(delegate: self)
        self.emailConfirmationScreen?.emailErrorLabel.isHidden = true
        //coloca a responsabilidade do delegate na viewController
        //        self.emailConfirmationScreen?.configTextFieldDelegate(delegate: self)
        self.auth = Auth.auth()
        self.alert = Alert(controller: self)
        self.emailConfirmationScreen?.emailTextField.delegate = self
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        default:
            textField.resignFirstResponder()
        }
        return false
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    public func validateEmailId(emailID: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
        let trimmedString = emailID.trimmingCharacters(in: .whitespaces)
        let validateEmail = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let isValidateEmail = validateEmail.evaluate(with: trimmedString)
        return isValidateEmail
    }
    
    func didTapEmail() {
        let text =  self.emailConfirmationScreen?.emailTextField.text ?? ""
        let label =  self.emailConfirmationScreen?.emailErrorLabel
        
        if text.isEmpty {
            label?.text = "Por favor, insira seu e-mail"
            label?.isHidden = false
        } else if validateEmailId(emailID: text) == false {
            label?.text = "O e-mail deve ter o formato: nome@exemplo.com"
            label?.isHidden = false
        } else {
            label?.isHidden = true
        }
    }
    
    func actionGoBack() {
        self.navigationController?.popToRootViewController(animated: false)
    }
    
    func actionSignUpButton() {
        let vc: SignUpViewController = SignUpViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func resetPasswordAuth(email: String, onSuccess: @escaping() -> Void, onError: @escaping(_ errorMessage:String) -> Void) {
        Auth.auth().sendPasswordReset(withEmail: email) { (error) in
            if error == nil {
                onSuccess()
            } else {
                self.alert?.getAlert(titulo: "Atenção", mensagem: "Um error ocorreu. Tente novamente!")
            }
        }
        
    }
    
    func actionGoToCodeButton() {
        guard let email = self.emailConfirmationScreen?.emailTextField.text else {return}
        
        if email.isEmpty {
            self.alert?.getAlert(titulo: "Atenção", mensagem: "Insira um e-mail")
        } else {
            resetPasswordAuth(email: email, onSuccess: {
                
                self.view.endEditing(true)
                self.alert?.getAlert(titulo: "E-mail enviado", mensagem: "Por favor, verifique o link enviado em seu e-mail para definir uma nova senha", completion: {
                    self.navigationController?.popViewController(animated: true)
                })
            })
            { (errorMessage) in
                self.alert?.getAlert(titulo: "Atenção", mensagem: "Verifique o e-mail inserido e tente novamente.")
            }
        }
    }
}

