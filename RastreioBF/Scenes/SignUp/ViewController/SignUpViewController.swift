//
//  SignUpViewController.swift
//  RastreioBF
//
//  Created by Jessica Bigal on 09/09/22.
//

import UIKit
import FirebaseAuth

class SignUpViewController: UIViewController{
    
    let signUpScreen = SignUpView()
    var auth:Auth?
    var alert:Alert?
    var textfield = UITextField()
    var viewModel: SignUpViewModel = SignUpViewModel()
    
    override func loadView() {
        self.view = self.signUpScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        signUpScreen.delegate(delegate: self)
        hideErrorLabels()
        auth = Auth.auth()
        alert = Alert(controller: self)
        setupKeyboardHiding()
        textfieldDelegate()
    }
    
    private func setupKeyboardHiding() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func textfieldDelegate(){
        signUpScreen.nameTextField.delegate = self
        signUpScreen.surnameTextField.delegate = self
        signUpScreen.emailTextField.delegate = self
        signUpScreen.passwordTextField.delegate = self
        signUpScreen.confirmPasswordTextField.delegate = self
    }
    
    private func hideErrorLabels(){
        signUpScreen.nameErrorLabel.isHidden = true
        signUpScreen.surnameErrorLabel.isHidden = true
        signUpScreen.emailErrorLabel.isHidden = true
        signUpScreen.passwordErrorLabel.isHidden = true
        signUpScreen.confirmPasswordErrorLabel.isHidden = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

extension SignUpViewController:UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case self.signUpScreen.nameTextField:
            self.signUpScreen.surnameTextField.becomeFirstResponder()
        case self.signUpScreen.surnameTextField:
            self.signUpScreen.emailTextField.becomeFirstResponder()
        case self.signUpScreen.emailTextField:
            self.signUpScreen.passwordTextField.becomeFirstResponder()
        case self.signUpScreen.passwordTextField:
            self.signUpScreen.confirmPasswordTextField.becomeFirstResponder()
        default:
            textField.resignFirstResponder()
        }
        return false
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if(textField == self.signUpScreen.confirmPasswordTextField) { self.signUpScreen.confirmPasswordTextField.isSecureTextEntry = true }
        if(textField == self.signUpScreen.passwordTextField) { self.signUpScreen.passwordTextField.isSecureTextEntry = true }
    }
}

extension SignUpViewController: SignUpViewProtocol {
    
    //MARK: - Error Labels
    func didTapName() {
        viewModel.verifyName(text: self.signUpScreen.nameTextField.text ?? "",
                             label: self.signUpScreen.nameErrorLabel)
    }
    
    func didTapSurname() {
        viewModel.verifySurname(text: self.signUpScreen.surnameTextField.text ?? "",
                                label: self.signUpScreen.surnameErrorLabel)
    }
    
    func didTapEmail() {
        viewModel.verifyEmail(text: self.signUpScreen.emailTextField.text ?? "",
                              label: self.signUpScreen.emailErrorLabel)
    }
    
    func didTapPassword() {
        viewModel.verifyPassword(text: self.signUpScreen.passwordTextField.text ?? "",
                                 label: self.signUpScreen.passwordErrorLabel)
    }
    
    func didTapConfirmPassword() {
        viewModel.verifyConfirmPassword(text: self.signUpScreen.confirmPasswordTextField.text ?? "",
                                        label: self.signUpScreen.confirmPasswordErrorLabel,
                                        password: self.signUpScreen.passwordTextField.text ?? "")
    }
    
    func registerUser(userUsername userName:String, userEmail email:String, userPassword password: String, userCreationComplete: @escaping (_ status: Bool, _ error: Error?) -> ()) {
        
        let user = Auth.auth().currentUser
        if let user = user {
            _ = user.uid
            _ = user.email
            var multiFactorString = "MultiFactor: "
            for info in user.multiFactor.enrolledFactors {
                multiFactorString += info.displayName ?? "[\(String(describing: self.signUpScreen.nameTextField.text))]"
                multiFactorString += " "
            }
        }
    }
    
    private var authUser : User? {
        return Auth.auth().currentUser
    }
    
    public func sendVerificationMail() {
        if self.authUser != nil && !self.authUser!.isEmailVerified {
            self.authUser!.sendEmailVerification(completion: { (error) in
                self.alert?.getAlert(titulo: LC.atentionTitle.text, mensagem: LC.errorOccurred.text)
            })
        }
        else {
            self.alert?.getAlert(titulo: LC.atentionTitle.text, mensagem: LC.emailSentConfirm.text)
        }
    }
    
    func signUpValidation(){
        
        if viewModel.verifySignUp(nameError: signUpScreen.hasNameLabel,
                                  surnameError: signUpScreen.hasSurnameLabel,
                                  emailError: signUpScreen.hasEmailLabel,
                                  passwordError: signUpScreen.hasPasswordLabel,
                                  confPassError: signUpScreen.hasConfPasswordLabel,
                                  nameText: signUpScreen.hasNameTextField,
                                  surnameText: signUpScreen.hasSurnameTextField,
                                  emailText: signUpScreen.hasEmailTextField,
                                  passwordText: signUpScreen.hasPasswordTextField ,
                                  confirmPasswordText: signUpScreen.hasConfPasswordTextField) {
            
            if let email = self.signUpScreen.emailTextField.text ,
               let password = self.signUpScreen.passwordTextField.text {
                
                Auth.auth().createUser(withEmail: email, password: password, completion: { user, error in
                    
                    if let firebaseError = error {
                        print(firebaseError.localizedDescription)
                        return
                    }
                    
                    self.sendVerificationMail()
                })
            }
            self.alert?.getAlert(titulo: LC.congrats.text,
                                 mensagem: LC.emailSentConfirm.text,
                                 completion: {
                let vc: LoginViewController = LoginViewController()
                self.navigationController?.pushViewController(vc, animated: false)
            })
        } else {
            self.alert?.getAlert(titulo: LC.atentionTitle.text, mensagem: LC.correctlyFilled.text)
        }
    }
    
    func actionSignUpButton() {
        signUpValidation()
        
    }
    
    func actionGoToLoginButton() {
        let vc: LoginViewController = LoginViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - Keyboard
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
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        view.frame.origin.y = 0
    }
}


