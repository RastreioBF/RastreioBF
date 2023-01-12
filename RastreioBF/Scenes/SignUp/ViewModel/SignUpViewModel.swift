//
//  SignUpViewModel.swift
//  RastreioBF
//
//  Created by Jessica Bigal on 04/12/22.
//

import Foundation

class SignUpViewModel {
 
    func verifySignUp(nameError: Bool, surnameError: Bool, emailError: Bool, passwordError: Bool, confPassError: Bool, nameText: Bool, surnameText: Bool, emailText: Bool, passwordText: Bool, confirmPasswordText: Bool) -> Bool {
        
        return nameError && surnameError && emailError && passwordError && confPassError && nameText &&  surnameText && emailText && passwordText && confirmPasswordText
    }
    
}
