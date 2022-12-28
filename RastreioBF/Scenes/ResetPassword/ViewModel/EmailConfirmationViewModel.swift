//
//  EmailConfirmationViewModel.swift
//  RastreioBF
//
//  Created by Jessica Bigal on 10/11/22.
//

import Foundation
import FirebaseAuth


class EmailConfirmationViewModel: EmailConfirmationViewModelProtocol {
    
    var auth:Auth?
    var navigationListener: EmailConfirmationCoordinatorProtocol?
    var viewController: UIViewController?
    var emailConfirmationScreen: EmailConfirmationScreen?
    
    init(auth: Auth = Auth.auth()) {
        self.auth = auth
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func validateEmailId(emailID: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
        let trimmedString = emailID.trimmingCharacters(in: .whitespaces)
        let validateEmail = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let isValidateEmail = validateEmail.evaluate(with: trimmedString)
        return isValidateEmail
    }
    
    func emailMaskVerify(text: String, label: UILabel, messageEmpty: String, messageEmailError: String) {
        if text.isEmpty {
            label.text = messageEmpty
            label.isHidden = false
        } else if validateEmailId(emailID: text) == false {
            label.text = messageEmailError
            label.isHidden = false
        } else {
            label.isHidden = true
        }
    }
    
    func isTextFieldEmpty(text: String)->Bool{
        return text.isEmpty
    }
    
    
    func actionGoBack() {
        navigationListener?.actionGoBack()
    }
    
    func actionSignUpButton() {
        navigationListener?.actionSignUpButton()
    }
    
    
}
