//
//  EmailConfirmationViewModel.swift
//  RastreioBF
//
//  Created by Jessica Bigal on 10/11/22.
//

import Foundation

class EmailConfirmationViewModel: EmailConfirmationViewModelProtocol {
    var navigationListener: EmailConfirmationCoordinatorProtocol?
    
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
