//
//  EmailConfirmationViewModel.swift
//  RastreioBF
//
//  Created by Jessica Bigal on 10/11/22.
//

import Foundation
import FirebaseAuth


class EmailConfirmationViewModel: UIViewController, EmailConfirmationViewModelProtocol {
    var auth:Auth?
//    var alert:Alert
    var navigationListener: EmailConfirmationCoordinatorProtocol?
    
    init(
        auth: Auth = Auth.auth()
    ) {
        //        self.emailConfirmationScreen?.configTextFieldDelegate(delegate: self)
        super.init(nibName: nil, bundle: nil)
        self.auth = auth
//        self.alert = Alert(controller: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func validateEmailId(emailID: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
        let trimmedString = emailID.trimmingCharacters(in: .whitespaces)
        let validateEmail = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let isValidateEmail = validateEmail.evaluate(with: trimmedString)
        return isValidateEmail
    }
    
    func didTapEmail() {
//        let text =  self.emailConfirmationScreen.emailTextField.text ?? ""
//        let label =  self.emailConfirmationScreen.emailErrorLabel
//
//        if text.isEmpty {
//            label.text = "Por favor, insira seu e-mail"
//            label.isHidden = false
//        } else if validateEmailId(emailID: text) == false {
//            label.text = "O e-mail deve ter o formato: nome@exemplo.com"
//            label.isHidden = false
//        } else {
//            label.isHidden = true
//        }
    }
    
 
    
    func resetPasswordAuth(email: String, onSuccess: @escaping() -> Void, onError: @escaping(_ errorMessage:String) -> Void) {
        Auth.auth().sendPasswordReset(withEmail: email) { (error) in
            if error == nil {
                onSuccess()
            } else {
//                self.alert.getAlert(titulo: "Atenção", mensagem: "Um error ocorreu. Tente novamente!")
            }
        }
        
    }
    
    func actionGoToCodeButton() {
//        guard let email = self.emailConfirmationScreen.emailTextField.text else {return}
//
//        if email.isEmpty {
//            self.alert.getAlert(titulo: "Atenção", mensagem: "Insira um e-mail")
//        } else {
//            resetPasswordAuth(email: email, onSuccess: {
//
//                self.view.endEditing(true)
//                self.alert.getAlert(titulo: "E-mail enviado", mensagem: "Por favor, verifique o link enviado em seu e-mail para definir uma nova senha", completion: {
//                    self.navigationController?.popViewController(animated: true)
//                })
//            })
//            { (errorMessage) in
//                self.alert.getAlert(titulo: "Atenção", mensagem: "Verifique o e-mail inserido e tente novamente.")
//            }
//        }
    }
    
    func actionGoBack() {
        navigationListener?.actionGoBack()
    }
    
    func actionSignUpButton() {
        navigationListener?.actionSignUpButton()
    }
}
