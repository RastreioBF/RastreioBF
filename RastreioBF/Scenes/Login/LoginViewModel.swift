//
//  LoginViewModel.swift
//  RastreioBF
//
//  Created by Jessica Bigal on 04/12/22.
//

import Foundation
import UIKit

class LoginViewModel {
    
    func emptyTextField(text: String) -> Bool {
        return text.isEmpty
    }
    
    func validateFields(button: UIButton, password: UITextField, errorLabel: UILabel, email: UITextField) {
        
        if button.isSelected == true {
            if password.state.isEmpty == false || email.state.isEmpty == false {
                errorLabel.text = ""
            } else {
                errorLabel.text = LC.fieldsMustBeFilleds.text
                button.isEnabled = false
            }
        }
    }
    
}
