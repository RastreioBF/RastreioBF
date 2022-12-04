//
//  SignUpViewModel.swift
//  RastreioBF
//
//  Created by Jessica Bigal on 04/12/22.
//

import Foundation
import UIKit

class SignUpViewModel {
    
    //MARK: - TextField Masks
    
    func isValidName(_ nameString: String) -> Bool {
        
        var returnValue = true
        let mobileRegEx =  "^\\w{3,18}$"
        
        do {
            let regex = try NSRegularExpression(pattern: mobileRegEx)
            let nsString = nameString as NSString
            let results = regex.matches(in: nameString, range: NSRange(location: 0, length: nsString.length))
            
            if results.count == 0
            {
                returnValue = false
            }
            
        } catch let error as NSError {
            print("invalid regex: \(error.localizedDescription)")
            returnValue = false
        }
        return  returnValue
    }
    
    public func validateName(name: String) ->Bool {
        var returnValue = true
        let mobileRegEx =  "^\\w{3,18}$"
        
        do {
            let regex = try NSRegularExpression(pattern: mobileRegEx)
            let nsString = name as NSString
            let results = regex.matches(in: name, range: NSRange(location: 0, length: nsString.length))
            
            if results.count == 0
            {
                returnValue = false
            }
            
        } catch let error as NSError {
            print("invalid regex: \(error.localizedDescription)")
            returnValue = false
        }
        return  returnValue
    }
    
    public func validateEmailId(emailID: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
        let trimmedString = emailID.trimmingCharacters(in: .whitespaces)
        let validateEmail = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let isValidateEmail = validateEmail.evaluate(with: trimmedString)
        return isValidateEmail
    }
    
    func containsDigit(_ value: String) -> Bool {
        let reqularExpression = ".*[0-9]+.*"
        let predicate = NSPredicate(format: "SELF MATCHES %@", reqularExpression)
        return !predicate.evaluate(with: value)
    }
    
    func containsLowerCase(_ value: String) -> Bool {
        let reqularExpression = ".*[a-z]+.*"
        let predicate = NSPredicate(format: "SELF MATCHES %@", reqularExpression)
        return !predicate.evaluate(with: value)
    }
    
    func containsUpperCase(_ value: String) -> Bool {
        let reqularExpression = ".*[A-Z]+.*"
        let predicate = NSPredicate(format: "SELF MATCHES %@", reqularExpression)
        return !predicate.evaluate(with: value)
    }
    
    func verifyName(text: String, label: UILabel) {
        if text.isEmpty {
            label.text = LC.emptyNameError.text
            label.isHidden = false
        } else if isValidName(text) == false {
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
        } else if isValidName(text) == false {
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
        } else if validateEmailId(emailID: text) == false {
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
