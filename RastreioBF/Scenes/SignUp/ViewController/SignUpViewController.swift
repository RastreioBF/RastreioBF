//
//  SignUpViewController.swift
//  RastreioBF
//
//  Created by Jessica Bigal on 09/09/22.
//

import UIKit
import FirebaseAuth

class SignUpViewController: UIViewController, UITextFieldDelegate {
    
    var signUpScreen: SignUpView?
    var auth:Auth?
    var alert:Alert?
    var textfield = UITextField()
    
    override func loadView() {
        self.signUpScreen = SignUpView()
        self.view = self.signUpScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.signUpScreen?.configTextFieldDelegate(delegate: self)
        self.signUpScreen?.delegate(delegate: self)
        self.hideErrorLabels()
        self.auth = Auth.auth()
        self.alert = Alert(controller: self)
        self.setupKeyboardHiding()
        self.signUpScreen?.nameTextField.delegate = self
        self.signUpScreen?.surnameTextField.delegate = self
        self.signUpScreen?.emailTextField.delegate = self
        self.signUpScreen?.passwordTextField.delegate = self
        self.signUpScreen?.confirmPasswordTextField.delegate = self
    }
    
    private func setupKeyboardHiding() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func hideErrorLabels(){
        self.signUpScreen?.nameErrorLabel.isHidden = true
        self.signUpScreen?.surnameErrorLabel.isHidden = true
        self.signUpScreen?.emailErrorLabel.isHidden = true
        self.signUpScreen?.passwordErrorLabel.isHidden = true
        self.signUpScreen?.confirmPasswordErrorLabel.isHidden = true
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case self.signUpScreen?.nameTextField:
            self.signUpScreen?.surnameTextField.becomeFirstResponder()
        case self.signUpScreen?.surnameTextField:
            self.signUpScreen?.emailTextField.becomeFirstResponder()
        case self.signUpScreen?.emailTextField:
            self.signUpScreen?.passwordTextField.becomeFirstResponder()
        case self.signUpScreen?.passwordTextField:
            self.signUpScreen?.confirmPasswordTextField.becomeFirstResponder()
        default:
            textField.resignFirstResponder()
        }
        return false
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {

        if(textField == self.signUpScreen?.confirmPasswordTextField) { self.signUpScreen?.confirmPasswordTextField.isSecureTextEntry = true }
        if(textField == self.signUpScreen?.passwordTextField) { self.signUpScreen?.passwordTextField.isSecureTextEntry = true }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

//extension SignUpViewController:UITextFieldDelegate {
//
//    //chamamos a funcao de validacao sempre no didend editing, pq ele so valida quando o tecldo baixou
//    func textFieldDidEndEditing(_ textField: UITextField) {
//                self.signUpScreen?.validaTextFields()
//    }
//
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        textField.resignFirstResponder()
//        return true
//    }
//
//
//}

extension SignUpViewController: SignUpViewProtocol {
    
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
            label?.text = "O sobrenome deve conter no minimo 3 caracteres"
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
    
    //Checks e-mail
    private var authUser : User? {
        return Auth.auth().currentUser
    }

    public func sendVerificationMail() {
        if self.authUser != nil && !self.authUser!.isEmailVerified {
            self.authUser!.sendEmailVerification(completion: { (error) in
                // Notify the user that the mail has sent or couldn't because of an error.
            })
        }
        else {
            // Either the user is not available, or the user is already verified.
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
        let vc:DemoViewController = DemoViewController()
        
        if nameError == true && surnameError == true && emailError == true && passwordError == true && confPassError == true && !nameText.isEmpty &&  !surnameText.isEmpty && !emailText.isEmpty && !passwordText.isEmpty && !confirmPasswordText.isEmpty {
            
            if let email = self.signUpScreen?.emailTextField.text , let password = self.signUpScreen?.passwordTextField.text {

                   Auth.auth().createUser(withEmail: email, password: password, completion: { user, error in

                       if let firebaseError = error {
                           print(firebaseError.localizedDescription)
                           return
                       }

                       self.sendVerificationMail()
                   })
            }
            
            self.alert?.getAlert(titulo: "Parabéns",
                                 mensagem: "Um e-mail de confirmacao foi enviado para ativacao da sua conta",
                                 completion: {
                let vc:LoginViewController = LoginViewController()
                self.navigationController?.pushViewController(vc, animated: true)
            })
//            guard let register = self.signUpScreen else {return}
//            self.auth?.createUser(withEmail: register.getEmail(), password: register.getPassword(), completion: { (result, error) in
//
//                if error != nil{
//                    self.alert?.getAlert(titulo: "Atenção", mensagem: "Erro ao cadastrar")
//                }else{
//                    self.alert?.getAlert(titulo: "Parabens", mensagem: "Usuario cadastrado com sucesso", completion: {
//                        let vc:DemoViewController = DemoViewController()
//                        self.navigationController?.pushViewController(vc, animated: true)
//                    })
//                }
//            })
            
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

// MARK: Keyboard
extension SignUpViewController {
    @objc func keyboardWillShow(sender: NSNotification) {
        guard let userInfo = sender.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue,
              let currentTextField = UIResponder.currentFirst() as? UITextField else { return }
        
        let keyboardTopY = keyboardFrame.cgRectValue.origin.y
        let convertedTextFieldFrame = view.convert(currentTextField.frame, from: currentTextField.superview)
        let textFieldBottomY = convertedTextFieldFrame.origin.y + convertedTextFieldFrame.size.height
        
        if textFieldBottomY > keyboardTopY {
            let textBoxY = convertedTextFieldFrame.origin.y
            let newFrameY = (textBoxY - keyboardTopY / 1.7) * -1
            view.frame.origin.y = newFrameY
        }

        print("foo - userInfo: \(userInfo)")
        print("foo - keyboardFrame: \(keyboardFrame)")
        print("foo - currentTextField: \(currentTextField)")
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
          view.frame.origin.y = 0
      }
}


