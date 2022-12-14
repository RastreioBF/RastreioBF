//
//  LoginViewController.swift
//  RastreioBF
//
//  Created by Jessica Bigal on 09/09/22.
//

import UIKit

import UIKit
import FirebaseAuth
import GoogleSignIn

class LoginViewController: UIViewController, LoginScreenProtocol, UITextFieldDelegate {
   
    var auth:Auth?
    var loginScreen:LoginScreen?
    var alert:Alert?
    let signInConfig = GIDConfiguration(clientID: "614878693717-p6uad96i9eltvcigv9o8o589su8flt41.apps.googleusercontent.com")
    
    //LoadView eh responsavel para quando estamos criando uma view
    override func loadView() {
        self.loginScreen = LoginScreen()
        //aqui dizemos que a nossa view eh igual a login screen
        self.view = self.loginScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loginScreen?.loginErrorLabel.isHidden = true
        self.loginScreen?.delegate(delegate: self)
        self.validationFields()
        //coloca a responsabilidade do delegate na viewController
        //        self.loginScreen?.configTextFieldDelegate(delegate: self)
        self.auth = Auth.auth()
        self.alert = Alert(controller: self)
        self.loginScreen?.emailTextField.delegate = self
        self.loginScreen?.passwordTextField.delegate = self
        self.setupKeyboardHiding()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        //retira a sombra da navigationController
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    private func setupKeyboardHiding() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func signIn(sender: Any) {
      GIDSignIn.sharedInstance.signIn(with: signInConfig, presenting: self) { user, error in
        guard error == nil else { return }
          
          let vc: MainTabBarController = MainTabBarController()
          self.navigationController?.pushViewController(vc, animated: false)
      }
    }
    
    func signOut(sender: Any) {
      GIDSignIn.sharedInstance.signOut()
    }
    
    
    func tappedMockado() {
        let vc: MainTabBarController = MainTabBarController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func actionLoginButton() {
        
//        var email = self.loginScreen?.emailTextField.text ?? ""
//        var password = self.loginScreen?.passwordTextField.text ?? ""
//
//        guard let login = self.loginScreen else {return}
//
//        if email.isEmpty || password.isEmpty {
//            self.loginScreen?.loginErrorLabel.text = "Todos os campos devem ser preenchidos"
//            self.loginScreen?.loginErrorLabel.isHidden = false
//        } else {
//            self.auth?.signIn(withEmail: login.getEmail(), password: login.getPassword(), completion: { (usuario, error) in
//                if error != nil{
//                    self.loginScreen?.loginErrorLabel.text = "Dados incorretos, verifique e tente novamente!"
//                    self.loginScreen?.loginErrorLabel.isHidden = false
//                }else{
//
//                    if usuario == nil{
//                        self.alert?.getAlert(titulo: "Aten????o", mensagem: "Tivemos um problema inesperado, tente novamente mais tarde.")
//                    }else{
                        let vc: MainTabBarController = MainTabBarController()
                        self.navigationController?.pushViewController(vc, animated: true)
//                    }
//                }
//            })
//
//        }
    }
    
    
//    func textFieldDidBeginEditing(_ textField: UITextField) {
//        self.loginScreen?.validaTextFields()
//        print("textFieldBeginEditing")
//    }
    
    //Cria o metodo que ira baixar o teclado ao clicar em "done"
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case self.loginScreen?.emailTextField:
            self.loginScreen?.passwordTextField.becomeFirstResponder()
        default:
            textField.resignFirstResponder()
        }
        return false
    }
    
//    func textFieldDidEndEditing(_ textField: UITextField) {
//        print("textFielEndEditing")
//    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func actionGoogleButton() {
        let vc: SignUpViewController = SignUpViewController()
        self.navigationController?.pushViewController(vc, animated: true)
        //        self.validationFields()
    }
    
    func actionSignUpButton() {
        let vc: SignUpViewController = SignUpViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func actionForgotPassword() {
        let vc:EmailConfirmationViewController = EmailConfirmationViewController()
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func checkLogin(){
        self.loginScreen?.loginButton.isEnabled = false
        
        self.loginScreen?.loginErrorLabel.isHidden = true
    }
    
    func validationFields(){
        
        if self.loginScreen?.loginButton.isSelected == true {
            if self.loginScreen?.passwordTextField.state.isEmpty == false || self.loginScreen?.emailTextField.state.isEmpty == false {
                self.loginScreen?.loginErrorLabel.text = ""
            } else {
                self.loginScreen?.loginErrorLabel.text = "Os campos devem ser preenchidos"
                self.loginScreen?.loginButton.isEnabled = false
            }
            
        }
    }
    
}

//endereca o delegate do UITextField para a ViewController
//extension LoginViewController:UITextFieldDelegate{
//
//
//    func textFieldDidBeginEditing(_ textField: UITextField) {
//        self.loginScreen?.validaTextFields()
//        print("textFieldBeginEditing")
//    }
//
//    //Cria o metodo que ira baixar o teclado ao clicar em "done"
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        switch textField {
//        case self.loginScreen?.emailTextField:
//            self.loginScreen?.passwordTextField.becomeFirstResponder()
//        default:
//            textField.resignFirstResponder()
//        }
//        return false
//    }
//
//    func textFieldDidEndEditing(_ textField: UITextField) {
//        print("textFielEndEditing")
//    }
//
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        self.view.endEditing(true)
//    }
//
//}

extension String{
    
    public func validaPhoneNumber(phoneNumber: String) -> Bool {
        //      let phoneNumberRegex = "^[6-9]\d{9}$"
        let phoneNumberRegex = ""
        let trimmedString = phoneNumber.trimmingCharacters(in: .whitespaces)
        let validatePhone = NSPredicate(format: "SELF MATCHES %@", phoneNumberRegex)
        let isValidPhone = validatePhone.evaluate(with: trimmedString)
        return isValidPhone
    }
  
    public func validatePassword(password: String) -> Bool {
        //Minimum 8 characters at least 1 Alphabet and 1 Number:
        //      let passRegEx = "^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$"
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
}

extension LoginViewController {
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
