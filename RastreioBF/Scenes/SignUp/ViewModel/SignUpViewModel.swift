//
//  SignUpViewModel.swift
//  RastreioBF
//
//  Created by Jessica Bigal on 04/12/22.
//

import Foundation
import UIKit

class SignUpViewModel {
    
    func verifyName(text: String, label: UILabel) {
        if text.isEmpty {
            label.text = LC.emptyNameError.text
            label.isHidden = false
        } else if Masks.shared.isValidName(text) == false {
            label.text = LC.nameTargetError.text
            label.isHidden = false
        } else {
            label.isHidden = true
        }
    }
    
    func verifySurname(text: String, label: UILabel) {
        if text.isEmpty {
            label.text = LC.emptySurnameError.text
            label.isHidden = false
        } else if Masks.shared.isValidName(text) == false {
            label.text = LC.surnameTargetError.text
            label.isHidden = false
        } else {
            label.isHidden = true
        }
    }
    
    func verifyEmail(text: String, label: UILabel) {
        if text.isEmpty {
            label.text = LC.emptyEmailError.text
            label.isHidden = false
        } else if Masks.shared.validateEmailId(emailID: text) == false {
            label.text = LC.emailFormatError.text
            label.isHidden = false
        } else {
            label.isHidden = true
        }
    }
    
    func verifyPassword(text: String, label: UILabel) {
        if text.isEmpty {
            label.text = LC.emptyPasswordError.text
            label.isHidden = false
        } else if text.count < 6 {
            label.text = LC.passwordTargetError.text
            label.isHidden = false
        } else {
            label.isHidden = true
        }
    }
    
    func verifyConfirmPassword(text: String, label: UILabel, password: String) {
        if text.isEmpty {
            label.text = LC.emptyConfirmPasswordError.text
            label.isHidden = false
        } else if text != password {
            label.text = LC.passwordsNotEqualError.text
            label.isHidden = false
        } else {
            label.isHidden = true
        }
    }
    
    func verifySignUp(nameError: Bool, surnameError: Bool, emailError: Bool, passwordError: Bool, confPassError: Bool, nameText: Bool, surnameText: Bool, emailText: Bool, passwordText: Bool, confirmPasswordText: Bool) -> Bool {
        
        return nameError && surnameError && emailError && passwordError && confPassError && nameText &&  surnameText && emailText && passwordText && confirmPasswordText
    }
    
}
