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

//Protocolos com as funcoes de acao dos botoes
protocol LoginScreenProtocol:AnyObject {
    func actionLoginButton()
    func actionSignUpButton()
    func signIn(sender: Any)
    func actionForgotPassword()
    func tappedMockado()
}

//A viewController eh responsavel por saber que exitem os elementos, nela contem as ligacoes que referenciam ao elemento, a view eh responsavel por conter todos os elementos e suas configuracoes
class LoginScreen: UIView {

//    var viewModel: LoginViewModel
    private var shouldFocusLink: Bool = false
    //acessa o protocolo
    weak var delegate:LoginScreenProtocol?
    //funcao para configurar o delegate
    func delegate(delegate:LoginScreenProtocol?){
        self.delegate = delegate
    }
    
    //Boa pratica: criar os elementos sempre com lazy para nao ocupar memoria persistente
    //MARK: Properties
    
    var animationUIView:UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var animationView:AnimationView = {
        var animation = AnimationView()
        animation = .init(name: "loginAnimation")
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
        image.image = UIImage(named:"loginImage")
        image.sizeToFit()
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    lazy var loginLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(named: "titlesColor")
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
        self.addSubview(self.animationUIView)
        animationUIView.addSubview(animationView)
        self.addSubview(self.loginLabel)
        self.addSubview(self.emailTextField)
        self.addSubview(self.loginErrorLabel)
        self.addSubview(self.passwordTextField)
        self.addSubview(self.recoverPasswordButton)
        self.addSubview(self.loginButton)
        self.addSubview(self.optionalLoginLabel)
        self.addSubview(self.googleBT)
        self.addSubview(self.registerLabel)
    }
    
    public func validaTextFields(){
        
        let email:String = self.emailTextField.text ?? ""
        let password:String = self.passwordTextField.text ?? ""
        
        //nao podem ser vazios
        if !email.isEmpty && !password.isEmpty {
            self.configButtonEnabled(true)
        } else {
            self.configButtonEnabled(false)
        }
    }
    
    private func configButtonEnabled(_ enable: Bool){
        if enable{
            self.loginButton.setTitleColor(.white, for: .normal)
            self.loginButton.isEnabled = true
        } else {
            self.loginButton.setTitleColor(.lightGray, for: .normal)
            self.loginButton.isEnabled = false
        }
    }
    
    public func getEmail()->String{
        return self.emailTextField.text ?? ""
    }
    
    public func getPassword()->String{
        return self.passwordTextField.text ?? ""
    }
    
    public func configTextFieldDelegate(delegate:UITextFieldDelegate) {
        //aqui definimos que o responsavel pelo textField eh o delegate
        self.emailTextField.delegate = delegate
        self.passwordTextField.delegate = delegate
    }
    
    @objc
    private func tappedLoginButton() {
        self.delegate?.actionLoginButton()
    }
    
    @objc
    private func tappedRegisterButton() {
        self.delegate?.actionSignUpButton()
    }
    
    @objc
    private func tappedGoogleBbutton() {
        self.delegate?.signIn(sender: self)
    }
    
    @objc
    private func tappedForgotPasswordBbutton() {
        self.delegate?.actionForgotPassword()
    }
    
    @objc
    func mockado(){
        self.delegate?.tappedMockado()
        }
    
    private func setUpConstraints(){
        self.setUpAnimationUIView()
        self.setUpLoginLabel()
        self.setUpLoginErrorLabel()
        self.setUpEmailText()
        self.setUpPasswordText()
        self.setUpLoginBt()
        self.setUpRegister()
        self.setUpRecoverBt()
        self.setUpRegisterLabel()
        self.setUpOptionalLogin()
        self.setUpGoogleBt()
    }
    
    private func setUpScrollView() {
        NSLayoutConstraint.activate([
            self.scrollView.topAnchor.constraint(equalTo: self.topAnchor),
            self.scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
            ])
    }
    
    private func setUpAnimationUIView() {
        NSLayoutConstraint.activate([
            self.animationUIView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20),
            self.animationUIView.bottomAnchor.constraint(equalTo: loginLabel.topAnchor, constant: -15),
            self.animationUIView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            self.animationUIView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15),
            self.animationUIView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.3),
            
            self.animationView.topAnchor.constraint(equalTo: animationUIView.safeAreaLayoutGuide.topAnchor),
            self.animationView.bottomAnchor.constraint(equalTo: animationUIView.safeAreaLayoutGuide.bottomAnchor),
            self.animationView.leadingAnchor.constraint(equalTo: animationUIView.safeAreaLayoutGuide.leadingAnchor),
            self.animationView.trailingAnchor.constraint(equalTo: animationUIView.safeAreaLayoutGuide.trailingAnchor)
            ])
    }
    
    
private func setUpLoginLabel() {
    NSLayoutConstraint.activate([
        self.loginLabel.bottomAnchor.constraint(equalTo: loginErrorLabel.topAnchor, constant: -1),
        self.loginLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
        self.loginLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15)
        ])
}

    private func setUpLoginErrorLabel() {
        NSLayoutConstraint.activate([
            self.loginErrorLabel.bottomAnchor.constraint(equalTo: emailTextField.topAnchor, constant: -1),
            self.loginErrorLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 17),
            self.loginErrorLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15)
            ])
    }
    
private func setUpEmailText() {
    NSLayoutConstraint.activate([
        self.emailTextField.bottomAnchor.constraint(equalTo: passwordTextField.topAnchor, constant: -10),
        self.emailTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
        self.emailTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15)
        ])
}

private func setUpPasswordText() {
    NSLayoutConstraint.activate([
        self.passwordTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
        self.passwordTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15),
        self.passwordTextField.bottomAnchor.constraint(equalTo: recoverPasswordButton.topAnchor, constant: -5)
        ])
}

private func setUpRecoverBt() {
    NSLayoutConstraint.activate([
        self.recoverPasswordButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
        self.recoverPasswordButton.bottomAnchor.constraint(equalTo: loginButton.topAnchor, constant: -20)
        ])
}

private func setUpLoginBt() {
    NSLayoutConstraint.activate([
        self.loginButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
        self.loginButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
        self.loginButton.bottomAnchor.constraint(equalTo: optionalLoginLabel.topAnchor, constant: -20),
        self.loginButton.heightAnchor.constraint(equalToConstant: 40)
        ])
}

private func setUpOptionalLogin() {
    NSLayoutConstraint.activate([
        self.optionalLoginLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        self.optionalLoginLabel.bottomAnchor.constraint(equalTo: googleBT.topAnchor, constant: -20),
        ])
}

private func setUpGoogleBt() {
    NSLayoutConstraint.activate([
        self.googleBT.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        self.googleBT.heightAnchor.constraint(equalToConstant: 40),
//        self.googleBT.widthAnchor.constraint(equalToConstant: 40)
        ])
}

    
    private func setUpRegisterLabel() {
        NSLayoutConstraint.activate([
            self.registerLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.registerLabel.topAnchor.constraint(equalTo: googleBT.bottomAnchor, constant:    20)
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

