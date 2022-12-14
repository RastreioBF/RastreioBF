//
//  EmailConfirmationProtocols.swift
//  RastreioBF
//
//  Created by Jessica Bigal on 10/11/22.
//

import Foundation

protocol EmailConfirmationScreenDelegate: AnyObject {
    func actionGoBackTapped()
    func actionGoToCodeButtonTapped()
    func didTapEmailTapped()
    func actionSignUpButtonTapped()
}

protocol EmailConfirmationViewModelProtocol: AnyObject {
    func actionGoBack()
    func actionSignUpButton()
}

protocol EmailConfirmationCoordinatorProtocol: AnyObject {
    func actionGoBack()
    func actionSignUpButton()
}
