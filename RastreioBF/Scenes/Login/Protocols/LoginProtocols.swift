//
//  LoginProtocols.swift
//  RastreioBF
//
//  Created by Jessica Bigal on 04/12/22.
//

import Foundation

protocol LoginViewProtocol: AnyObject {
    func actionLoginButton()
    func actionSignUpButton()
    func signIn(sender: Any)
    func actionForgotPassword()
}
