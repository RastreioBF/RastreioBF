//
//  SignUpProtocols.swift
//  RastreioBF
//
//  Created by Jessica Bigal on 04/12/22.
//

import Foundation

protocol SignUpViewProtocol: AnyObject{
    func actionGoToLoginButton()
    func actionSignUpButton()
    func didTapName()
    func didTapSurname()
    func didTapEmail()
    func didTapPassword()
    func didTapConfirmPassword()
}
