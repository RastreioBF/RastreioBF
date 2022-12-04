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
    
    public func validaPhoneNumber(phoneNumber: String) -> Bool {
        let phoneNumberRegex = ""
        let trimmedString = phoneNumber.trimmingCharacters(in: .whitespaces)
        let validatePhone = NSPredicate(format: "SELF MATCHES %@", phoneNumberRegex)
        let isValidPhone = validatePhone.evaluate(with: trimmedString)
        return isValidPhone
    }
    
    public func validatePassword(password: String) -> Bool {
        let passRegEx = ""
        let trimmedString = password.trimmingCharacters(in: .whitespaces)
        let validatePassord = NSPredicate(format:"SELF MATCHES %@", passRegEx)
        let isvalidatePass = validatePassord.evaluate(with: trimmedString)
        return isvalidatePass
    }
    public func validateAnyOtherTextField(otherField: String) -> Bool {
        let otherRegexString = "Your regex String"
        let trimmedString = otherField.trimmingCharacters(in: .whitespaces)
        let validateOtherString = NSPredicate(format: "SELF MATCHES %@", otherRegexString)
        let isValidateOtherString = validateOtherString.evaluate(with: trimmedString)
        return isValidateOtherString
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
