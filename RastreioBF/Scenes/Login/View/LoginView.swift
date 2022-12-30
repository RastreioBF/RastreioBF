//
//  LoginSreen.swift
//  RastreioBF
//
//  Created by Jessica Bigal on 09/09/22.
//

import UIKit
import UIKit.UITextField
import Foundation
import Lottie
import GoogleSignIn

class LoginView: UIView {
    
    private var shouldFocusLink: Bool = false
    
    weak var delegate:LoginViewProtocol?
    
    func delegate(delegate:LoginViewProtocol?){
        self.delegate = delegate
    }
    
    //MARK: Properties
    
    lazy var animationUIView:UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var animationView:AnimationView = {
        var animation = AnimationView()
        animation = .init(name: LC.loginAnimation.text)
        animation.contentMode = .scaleAspectFit
        animation.loopMode = .playOnce
        animation.animationSpeed = 0.5
        animation.translatesAutoresizingMaskIntoConstraints = false
        animation.play()
        return animation
    }()
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .clear
        return scrollView
    }()
    
    lazy var loginImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.sizeToFit()
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    lazy var loginLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(named: LC.titlesColor.text)
        label.font = UIFont.preferredFont(forTextStyle: .callout)
        label.font = .systemFont(ofSize: 25, weight: .semibold)
        label.text = LC.loginLabel.text
        label.textAlignment = .left
        return label
    }()
    
    lazy var emailTextField: UITextField = {
        let text = UITextField()
        text.backgroundColor = UIColor.clear
        text.layer.masksToBounds = true
        text.translatesAutoresizingMaskIntoConstraints = false
        text.placeholder = LC.emailPlaceHolder.text
        text.textAlignment = .left
        text.font = UIFont.systemFont(ofSize: 18)
        text.autocapitalizationType = .none
        text.leftViewMode = .always
        text.borderStyle = UITextField.BorderStyle.roundedRect
        text.keyboardType = UIKeyboardType.emailAddress
        text.returnKeyType = UIReturnKeyType.continue
        text.clearButtonMode = UITextField.ViewMode.whileEditing
        return text
    }()
    
    lazy var loginErrorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .systemRed
        label.font = UIFont.preferredFont(forTextStyle: .callout)
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.text = LC.loginErrorMessageLabel.text
        label.textAlignment = .left
        return label
    }()
    
    lazy var passwordTextField: UITextField = {
        let text = UITextField()
        text.backgroundColor = UIColor.clear
        text.layer.masksToBounds = true
        text.translatesAutoresizingMaskIntoConstraints = false
        text.placeholder = LC.passwordPlaceHolder.text
        text.textAlignment = .left
        text.font = UIFont.systemFont(ofSize: 18)
        text.borderStyle = UITextField.BorderStyle.roundedRect
        text.keyboardType = UIKeyboardType.default
        text.isSecureTextEntry.toggle()
        text.returnKeyType = UIReturnKeyType.done
        return text
    }()
    
    lazy var loginButton: UIButton = {
        var button = UIButton(type: .roundedRect)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(LC.login.text, for: .normal)
        button.titleLabel?.textAlignment = .center
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 8
        button.tintColor = .white
        button.addTarget(self, action: #selector(tappedLoginButton), for: .touchUpInside)
        return button
    }()
    
    lazy var recoverPasswordButton: UIButton = {
        var button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(LC.forgotPasswordBt.text, for: .normal)
        button.titleLabel?.textAlignment = .left
        button.setTitleColor(UIColor.systemBlue, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        button.addTarget(self, action: #selector(tappedForgotPasswordBbutton), for: .touchUpInside)
        return button
    }()
    
    lazy var optionalLoginLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .gray
        label.font = UIFont.preferredFont(forTextStyle: .callout)
        label.font = .systemFont(ofSize: 18, weight: .thin)
        label.text = LC.optionalLabel.text
        label.textAlignment = .center
        return label
    }()
    
    lazy var googleBT: GIDSignInButton = {
        var button = GIDSignInButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.colorScheme = .light
        button.style = .wide
        button.addTarget(self, action: #selector(tappedGoogleBbutton), for: .touchUpInside)
        return button
    }()
    
    lazy var registerLabel: UITextView = {
        let view = UITextView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isScrollEnabled = false
        view.isEditable = false
        view.textAlignment = .center
        view.accessibilityTraits = .link
        view.font = UIFont.systemFont(ofSize: 10)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        passwordTextField.enablePasswordToggle()
        self.configBackground()
        self.configSuperView()
        self.setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configBackground() {
        self.backgroundColor = .white
    }
    
    private func configSuperView() {
        addSubview(self.animationUIView)
        animationUIView.addSubview(animationView)
        addSubview(self.loginLabel)
        addSubview(self.emailTextField)
        addSubview(self.loginErrorLabel)
        addSubview(self.passwordTextField)
        addSubview(self.recoverPasswordButton)
        addSubview(self.loginButton)
        addSubview(self.optionalLoginLabel)
        addSubview(self.googleBT)
        addSubview(self.registerLabel)
    }
    
    public func validaTextFields(){
        
        let email:String = self.emailTextField.text ?? ""
        let password:String = self.passwordTextField.text ?? ""
        
        if !email.isEmpty && !password.isEmpty {
            configButtonEnabled(true)
        } else {
            configButtonEnabled(false)
        }
    }
    
    private func configButtonEnabled(_ enable: Bool){
        if enable{
            loginButton.setTitleColor(.white, for: .normal)
            loginButton.isEnabled = true
        } else {
            loginButton.setTitleColor(.lightGray, for: .normal)
            loginButton.isEnabled = false
        }
    }
    
    public func getEmail()->String{
        return emailTextField.text ?? ""
    }
    
    public func getPassword()->String{
        return passwordTextField.text ?? ""
    }
    
    public func configTextFieldDelegate(delegate:UITextFieldDelegate) {
        emailTextField.delegate = delegate
        passwordTextField.delegate = delegate
    }
    
    @objc
    private func tappedLoginButton() {
        delegate?.actionLoginButton()
    }
    
    @objc
    private func tappedRegisterButton() {
        delegate?.actionSignUpButton()
    }
    
    @objc
    private func tappedGoogleBbutton() {
        delegate?.signIn(sender: self)
    }
    
    @objc
    private func tappedForgotPasswordBbutton() {
        delegate?.actionForgotPassword()
    }
    
    private func setUpConstraints(){
        setUpAnimationUIView()
        setUpLoginLabel()
        setUpLoginErrorLabel()
        setUpEmailText()
        setUpPasswordText()
        setUpLoginBt()
        setUpRegister()
        setUpRecoverBt()
        setUpRegisterLabel()
        setUpOptionalLogin()
        setUpGoogleBt()
    }
    
    private func setUpScrollView() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
    
    private func setUpAnimationUIView() {
        NSLayoutConstraint.activate([
            animationUIView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20),
            animationUIView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            animationUIView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15),
            animationUIView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.3),
            
            animationView.topAnchor.constraint(equalTo: animationUIView.safeAreaLayoutGuide.topAnchor),
            animationView.bottomAnchor.constraint(equalTo: animationUIView.safeAreaLayoutGuide.bottomAnchor),
            animationView.leadingAnchor.constraint(equalTo: animationUIView.safeAreaLayoutGuide.leadingAnchor),
            animationView.trailingAnchor.constraint(equalTo: animationUIView.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    
    private func setUpLoginLabel() {
        NSLayoutConstraint.activate([
            loginLabel.topAnchor.constraint(equalTo: animationUIView.bottomAnchor, constant: 15),
            loginLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            loginLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15)
        ])
    }
    
    private func setUpLoginErrorLabel() {
        NSLayoutConstraint.activate([
            loginErrorLabel.topAnchor.constraint(equalTo: loginLabel.bottomAnchor, constant: 1),
            loginErrorLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 17),
            loginErrorLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15)
        ])
    }
    
    private func setUpEmailText() {
        NSLayoutConstraint.activate([
            emailTextField.topAnchor.constraint(equalTo: loginErrorLabel.bottomAnchor, constant: 1),
            emailTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            emailTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15)
        ])
    }
    
    private func setUpPasswordText() {
        NSLayoutConstraint.activate([
            passwordTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            passwordTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15),
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 10)
        ])
    }
    
    private func setUpRecoverBt() {
        NSLayoutConstraint.activate([
            recoverPasswordButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            recoverPasswordButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 5)
        ])
    }
    
    private func setUpLoginBt() {
        NSLayoutConstraint.activate([
            loginButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            loginButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            loginButton.topAnchor.constraint(equalTo: recoverPasswordButton.bottomAnchor, constant: 20),
            loginButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func setUpOptionalLogin() {
        NSLayoutConstraint.activate([
            optionalLoginLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            optionalLoginLabel.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 20),
        ])
    }
    
    private func setUpGoogleBt() {
        NSLayoutConstraint.activate([
            googleBT.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            googleBT.heightAnchor.constraint(equalToConstant: 40),
            googleBT.topAnchor.constraint(equalTo: optionalLoginLabel.bottomAnchor, constant: 20)
        ])
    }
    
    
    private func setUpRegisterLabel() {
        NSLayoutConstraint.activate([
            registerLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            registerLabel.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -25)
        ])
    }
    
    
    fileprivate func setUpRegister() {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.34
        
        let font: UIFont = .systemFont(ofSize: 12)
        let boldFont: UIFont = .boldSystemFont(ofSize: 12)
        
        let baseString = NSMutableAttributedString(string: LC.newHere.text,
                                                   attributes: [NSAttributedString.Key.paragraphStyle : paragraphStyle,
                                                                NSAttributedString.Key.font : font])
        
        let linkString = NSMutableAttributedString(string: LC.signUp.text, attributes: [NSAttributedString.Key.paragraphStyle : paragraphStyle,
                                                                                        NSAttributedString.Key.font : boldFont,
                                                                                        NSAttributedString.Key.link : tappedRegisterButton()
                                                                                       ])
        
        let tapButton = UITapGestureRecognizer(target: self, action: #selector(tappedRegisterButton))
        registerLabel.addGestureRecognizer(tapButton)
        
        baseString.append(linkString)
        
        registerLabel.linkTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.systemBlue,
            NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue,
            NSAttributedString.Key.underlineColor: UIColor.systemBlue
        ]
        
        registerLabel.attributedText = baseString
    }
    
}

