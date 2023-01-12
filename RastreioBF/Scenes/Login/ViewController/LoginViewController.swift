//
//  LoginViewController.swift
//  RastreioBF
//
//  Created by Jessica Bigal on 09/09/22.
//

import UIKit
import FirebaseAuth
import GoogleSignIn

class LoginViewController: UIViewController {
    
    var auth:Auth?
    var loginScreen:LoginView?
    var alert:Alert?
    var viewModel: LoginViewModel = LoginViewModel()
    let signInConfig = GIDConfiguration(clientID: LC.signInConfig.text)
    
    override func loadView() {
        loginScreen = LoginView()
        view = self.loginScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginScreen?.loginErrorLabel.isHidden = true
        loginScreen?.delegate(delegate: self)
        validationFields()
        auth = Auth.auth()
        alert = Alert(controller: self)
        textfieldDelegate()
        setupKeyboardHiding()
        
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        hidesBottomBarWhenPushed = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    private func setupKeyboardHiding() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func textfieldDelegate(){
        loginScreen?.emailTextField.delegate = self
        loginScreen?.passwordTextField.delegate = self
    }
    
    
    func signOut(sender: Any) {
        GIDSignIn.sharedInstance.signOut()
    }
    
    
    private var authUser : User? {
        return Auth.auth().currentUser
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func validationFields(){
        Masks.shared.validateFields(button: loginScreen?.loginButton ?? UIButton(), password: loginScreen?.passwordTextField ?? UITextField(), errorLabel: loginScreen?.loginErrorLabel ?? UILabel(), email: loginScreen?.emailTextField ?? UITextField())
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
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        view.frame.origin.y = 0
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case self.loginScreen?.emailTextField:
            self.loginScreen?.passwordTextField.becomeFirstResponder()
        default:
            textField.resignFirstResponder()
        }
        return false
    }
}

extension LoginViewController: LoginViewProtocol {
    
    func signIn(sender: Any) {
        GIDSignIn.sharedInstance.signIn(with: signInConfig, presenting: self) { [self] user, error in
            guard error == nil else { return }
            let vc: DemoViewController = DemoViewController()
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func actionLoginButton() {
        guard let login = self.loginScreen else {return}
        
        if viewModel.emptyTextField(text: self.loginScreen?.emailTextField.text ?? "") || viewModel.emptyTextField(text: self.loginScreen?.passwordTextField.text ?? "") {
            self.loginScreen?.loginErrorLabel.text = LC.allFieldsMustBeFilleds.text
            self.loginScreen?.loginErrorLabel.isHidden = false
        } else {
            self.auth?.signIn(withEmail: login.getEmail(), password: login.getPassword(), completion: { (usuario, error) in
                if error != nil{
                    self.loginScreen?.loginErrorLabel.text = LC.wrongData.text
                    self.loginScreen?.loginErrorLabel.isHidden = false
                } else if !Auth.auth().currentUser!.isEmailVerified {
                    self.alert?.getAlertActions(titulo: LC.atentionTitle.text, mensagem: LC.wrongEmailSignin.text, completion: {
                        self.authUser!.sendEmailVerification(completion: { (error) in
                        })
                    })
                } else if usuario == nil{
                    self.alert?.getAlert(titulo: LC.atentionTitle.text, mensagem: LC.tryAgainLater.text)
                }else{
                    if (self.auth?.currentUser?.metadata.creationDate == self.auth?.currentUser?.metadata.lastSignInDate
                    ) {
                        let vc: DemoViewController = DemoViewController()
                        self.navigationController?.pushViewController(vc, animated: true)
                    } else {
                        let vc: MainTabBarController = MainTabBarController()
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                }
            })
        }
    }
    
    func actionSignUpButton() {
        let vc: SignUpViewController = SignUpViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func actionForgotPassword() {
        let viewModel = EmailConfirmationViewModel()
        let vc: EmailConfirmationViewController = EmailConfirmationViewController(viewModel: viewModel)
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
}
