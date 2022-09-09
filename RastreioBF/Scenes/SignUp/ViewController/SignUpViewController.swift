//
//  SignUpViewController.swift
//  RastreioBF
//
//  Created by Jessica Bigal on 09/09/22.
//

import UIKit
import FirebaseAuth

class SignUpViewController: UIViewController {
    
    var signUpScreen: SignUpScreen?
    var auth:Auth?
    var alert:Alert?
    
    override func loadView() {
        self.signUpScreen = SignUpScreen()
        self.view = self.signUpScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.signUpScreen?.configTextFieldDelegate(delegate: self)
        self.signUpScreen?.delegate(delegate: self)
        self.hideErrorLabels()
        self.auth = Auth.auth()
        self.alert = Alert(controller: self)
    }
    
    func hideErrorLabels(){
        self.signUpScreen?.nameErrorLabel.isHidden = true
        self.signUpScreen?.surnameErrorLabel.isHidden = true
        self.signUpScreen?.emailErrorLabel.isHidden = true
        self.signUpScreen?.passwordErrorLabel.isHidden = true
        self.signUpScreen?.confirmPasswordErrorLabel.isHidden = true
    }
}

extension SignUpViewController:UITextFieldDelegate {
    
    //chamamos a funcao de validacao sempre no didend editing, pq ele so valida quando o tecldo baixou
    func textFieldDidEndEditing(_ textField: UITextField) {
        //        self.signUpScreen?.validaTextFields()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
}

extension SignUpViewController: SignUpScreenProtocol {
    
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
        // Length be 18 characters max and 3 characters minimum, you can always modify.
        let nameRegex = "^\\w{3,18}$"
        let trimmedString = name.trimmingCharacters(in: .whitespaces)
        let validateName = NSPredicate(format: "SELF MATCHES %@", nameRegex)
        let isValidateName = validateName.evaluate(with: trimmedString)
        return isValidateName
    }
    
    public func validateEmailId(emailID: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
        let trimmedString = emailID.trimmingCharacters(in: .whitespaces)
        let validateEmail = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let isValidateEmail = validateEmail.evaluate(with: trimmedString)
        return isValidateEmail
    }
    
    func containsDigit(_ value: String) -> Bool
    {
        let reqularExpression = ".*[0-9]+.*"
        let predicate = NSPredicate(format: "SELF MATCHES %@", reqularExpression)
        return !predicate.evaluate(with: value)
    }
    
    func containsLowerCase(_ value: String) -> Bool
    {
        let reqularExpression = ".*[a-z]+.*"
        let predicate = NSPredicate(format: "SELF MATCHES %@", reqularExpression)
        return !predicate.evaluate(with: value)
    }
    
    func containsUpperCase(_ value: String) -> Bool
    {
        let reqularExpression = ".*[A-Z]+.*"
        let predicate = NSPredicate(format: "SELF MATCHES %@", reqularExpression)
        return !predicate.evaluate(with: value)
    }
    
    
    //MARK: - Error Labels
    
    func didTapName() {
        let text =  self.signUpScreen?.nameTextField.text ?? ""
        let label =  self.signUpScreen?.nameErrorLabel
        
        if text.isEmpty {
            label?.text = "Por favor, insira seu nome"
            label?.isHidden = false
        } else if isValidName(text) == false {
            label?.text = "O nome deve conter no minimo 3 caracteres"
            label?.isHidden = false
        } else {
            label?.isHidden = true
        }
    }
    
    func didTapSurname() {
        let text =  self.signUpScreen?.surnameTextField.text ?? ""
        let label =  self.signUpScreen?.surnameErrorLabel
        
        if text.isEmpty {
            label?.text = "Por favor, insira seu sobrenome"
            label?.isHidden = false
        } else if isValidName(text) == false {
            label?.text = "O nome deve conter no minimo 3 caracteres"
            label?.isHidden = false
        } else {
            label?.isHidden = true
        }
    }
    
    func didTapEmail() {
        let text =  self.signUpScreen?.emailTextField.text ?? ""
        let label =  self.signUpScreen?.emailErrorLabel
        
        if text.isEmpty {
            label?.text = "Por favor, insira seu e-mail"
            label?.isHidden = false
        } else if validateEmailId(emailID: text) == false {
            label?.text = "O e-mail deve ter o formato: nome@exemplo.com"
            label?.isHidden = false
        } else {
            label?.isHidden = true
        }
    }
    
    func didTapPassword() {
        let text =  self.signUpScreen?.passwordTextField.text ?? ""
        let label =  self.signUpScreen?.passwordErrorLabel
        
        if text.isEmpty {
            label?.text = "Por favor, insira uma senha"
            label?.isHidden = false
            } else if text.count < 6 {
            label?.text = "A senha de ter no minimo 6 caracteres"
            label?.isHidden = false
        } else {
            label?.isHidden = true
        }
    }
    
    func didTapConfirmPassword() {
        let text =  self.signUpScreen?.confirmPasswordTextField.text ?? ""
        let password =  self.signUpScreen?.passwordTextField.text ?? ""
        let label =  self.signUpScreen?.confirmPasswordErrorLabel
        
        if text.isEmpty {
            label?.text = "Por favor, confirme sua senha"
            label?.isHidden = false
            } else if text != password {
            label?.text = "Deve ser igual a senha"
            label?.isHidden = false
        } else {
            label?.isHidden = true
        }
    }
    
    func registerUser(userUsername userName:String, userEmail email:String, userPassword password: String, userCreationComplete: @escaping (_ status: Bool, _ error: Error?) -> ()) {
        
        
        let user = Auth.auth().currentUser
        if let user = user {
            let uid = user.uid
            let email = user.email
            var multiFactorString = "MultiFactor: "
            for info in user.multiFactor.enrolledFactors {
                multiFactorString += info.displayName ?? "[\(String(describing: self.signUpScreen?.nameTextField.text))]"
                multiFactorString += " "
            }
        }
    }
    
    func signUpValidation(){
        let nameError = self.signUpScreen?.nameErrorLabel.isHidden
        let surnameError = self.signUpScreen?.surnameErrorLabel.isHidden
        let emailError = self.signUpScreen?.emailErrorLabel.isHidden
        let passwordError = self.signUpScreen?.passwordErrorLabel.isHidden
        let confPassError = self.signUpScreen?.confirmPasswordErrorLabel.isHidden
        
        let nameText =  self.signUpScreen?.nameTextField.text ?? ""
        let surnameText =  self.signUpScreen?.surnameTextField.text ?? ""
        let emailText =  self.signUpScreen?.emailTextField.text ?? ""
        let passwordText =  self.signUpScreen?.passwordTextField.text ?? ""
        let confirmPasswordText =  self.signUpScreen?.confirmPasswordTextField.text ?? ""
        
        if nameError == true && surnameError == true && emailError == true && passwordError == true && confPassError == true && !nameText.isEmpty &&  !surnameText.isEmpty && !emailText.isEmpty && !passwordText.isEmpty && !confirmPasswordText.isEmpty {
            
            self.alert?.getAlert(titulo: "Parabéns",
                                 mensagem: "Cadastro efetuado com sucesso!",
                                 completion: {
                self.navigationController?.popToRootViewController(animated: true)
            }
            )
            guard let register = self.signUpScreen else {return}
            self.auth?.createUser(withEmail: register.getEmail(), password: register.getPassword(), completion: { (result, error) in

                if error != nil{
                    self.alert?.getAlert(titulo: "Atenção", mensagem: "Erro ao cadastrar")
                }else{
                    self.alert?.getAlert(titulo: "Parabens", mensagem: "Usuario cadastrado com sucesso", completion: {
                        let vc:DemoViewController = DemoViewController()
                        self.navigationController?.pushViewController(vc, animated: true)
                    })
                }
            })
        } else {
            self.alert?.getAlert(titulo: "Atenção", mensagem: "Todos os campos devem estar preenchidos corretamente")
        }
    }
    
    func actionSignUpButton() {
        signUpValidation()
        
    }
    
    func actionGoToLoginButton() {
        let vc:LoginViewController = LoginViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
