//
//  SignUpScreen.swift
//  RastreioBF
//
//  Created by Jessica Bigal on 09/09/22.
//

import UIKit
import Lottie
import UIKit.UITextField
import Foundation

protocol SignUpScreenProtocol: AnyObject{
    func actionGoToLoginButton()
    func actionSignUpButton()
    func didTapName()
    func didTapSurname()
    func didTapEmail()
    func didTapPassword()
    func didTapConfirmPassword()
}

class SignUpScreen: UIView {
    
    // MARK: - Delegate
    private var shouldFocusLink: Bool = false
    weak var delegate:SignUpScreenProtocol?
    
    func delegate(delegate:SignUpScreenProtocol?) {
        self.delegate = delegate
    }
    
    // MARK: - UI Properties
    
    var animationUIView:UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var animationView:AnimationView = {
        var animation = AnimationView()
        animation = .init(name: "signUpAnimation")
        animation.contentMode = .scaleAspectFit
        animation.loopMode = .playOnce
        animation.animationSpeed = 0.5
        animation.translatesAutoresizingMaskIntoConstraints = false
        animation.play()
        return animation
    }()
    
    lazy var signUpLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(named: "titlesColor")
        label.font = UIFont.preferredFont(forTextStyle: .callout)
        label.font = .systemFont(ofSize: 25, weight: .semibold)
        label.text = LC.signUpLabel.text
        label.textAlignment = .left
        return label
    }()
    
    lazy var nameTextField: UITextField = {
        let text = UITextField()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.layer.masksToBounds = true
        text.backgroundColor = .clear
        text.textAlignment = .left
        text.font = UIFont.systemFont(ofSize: 18)
        text.borderStyle = UITextField.BorderStyle.roundedRect
        text.keyboardType = UIKeyboardType.default
        text.returnKeyType = UIReturnKeyType.continue
        text.clearButtonMode = UITextField.ViewMode.whileEditing
        text.placeholder = LC.namePlaceHolder.text
        text.addTarget(self, action: #selector(tappedName), for: .editingChanged)
        return text
    }()
    
    lazy var nameErrorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .systemRed
        label.font = UIFont.preferredFont(forTextStyle: .callout)
        label.font = .systemFont(ofSize: 10, weight: .regular)
        label.text = LC.emptyNameError.text
        label.textAlignment = .left
        return label
    }()
    
    lazy var surnameTextField: UITextField = {
        let text = UITextField()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.layer.masksToBounds = true
        text.backgroundColor = .clear
        text.textAlignment = .left
        text.font = UIFont.systemFont(ofSize: 18)
        text.borderStyle = UITextField.BorderStyle.roundedRect
        text.keyboardType = UIKeyboardType.default
        text.returnKeyType = UIReturnKeyType.continue
        text.clearButtonMode = UITextField.ViewMode.whileEditing
        text.placeholder = LC.surnamePlaceHolder.text
        text.addTarget(self, action: #selector(tappedSurname), for: .editingChanged)
        return text
    }()
    
    lazy var surnameErrorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .systemRed
        label.font = UIFont.preferredFont(forTextStyle: .callout)
        label.font = .systemFont(ofSize: 10, weight: .regular)
        label.text = LC.emptySurnameError.text
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
        text.borderStyle = UITextField.BorderStyle.roundedRect
        text.keyboardType = UIKeyboardType.emailAddress
        text.returnKeyType = UIReturnKeyType.continue
        text.clearButtonMode = UITextField.ViewMode.whileEditing
        text.addTarget(self, action: #selector(tappedEmail), for: .editingChanged)
        return text
    }()
    
    lazy var emailErrorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .systemRed
        label.font = UIFont.preferredFont(forTextStyle: .callout)
        label.font = .systemFont(ofSize: 10, weight: .regular)
        label.text = LC.emptyEmailError.text
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
        text.addTarget(self, action: #selector(tappedPassword), for: .editingChanged)
        return text
    }()
    
    lazy var passwordErrorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .systemRed
        label.font = UIFont.preferredFont(forTextStyle: .callout)
        label.font = .systemFont(ofSize: 10, weight: .regular)
        label.text = LC.emptyPasswordError.text
        label.textAlignment = .left
        return label
    }()
    
    lazy var confirmPasswordTextField: UITextField = {
        let text = UITextField()
        text.backgroundColor = UIColor.clear
        text.layer.masksToBounds = true
        text.translatesAutoresizingMaskIntoConstraints = false
        text.placeholder = LC.confirmPasswordPlaceHolder.text
        text.textAlignment = .left
        text.font = UIFont.systemFont(ofSize: 18)
        text.borderStyle = UITextField.BorderStyle.roundedRect
        text.keyboardType = UIKeyboardType.default
        text.isSecureTextEntry.toggle()
        text.returnKeyType = UIReturnKeyType.done
        text.addTarget(self, action: #selector(tappedConfirmPassword), for: .editingChanged)
        return text
    }()
    
    lazy var confirmPasswordErrorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .systemRed
        label.font = UIFont.preferredFont(forTextStyle: .callout)
        label.font = .systemFont(ofSize: 10, weight: .regular)
        label.text = LC.emptyConfirmPasswordError.text
        label.textAlignment = .left
        return label
    }()
    
    lazy var signUpButton: UIButton = {
        var button = UIButton(type: .roundedRect)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(LC.signUp.text, for: .normal)
        button.titleLabel?.textAlignment = .center
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 8
        button.tintColor = .white
        button.addTarget(self, action: #selector(tappedSignUpButton), for: .touchUpInside)
        return button
    }()
    
    lazy var alreadyMemberLabel: UITextView = {
        let view = UITextView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isScrollEnabled = false
        view.isEditable = false
        view.textAlignment = .center
        view.accessibilityTraits = .link
        view.font = UIFont.systemFont(ofSize: 10)
        return view
    }()
    
    //MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        passwordTextField.enablePasswordToggle()
//        confirmPasswordTextField.enablePasswordToggle()
        self.configBackground()
        self.errorMessagesHidden()
        self.configSuperView()
        self.configConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Actions Buttons
    
    @objc
    private func tappedName(){
        self.delegate?.didTapName()
    }
    
    @objc
    private func tappedSurname(){
        self.delegate?.didTapSurname()
    }
    
    @objc
    private func tappedEmail(){
        self.delegate?.didTapEmail()
    }
    
    @objc
    private func tappedPassword(){
        self.delegate?.didTapPassword()
    }
    
    @objc
    private func tappedConfirmPassword(){
        self.delegate?.didTapConfirmPassword()
    }
    
    @objc
    private func tappedSignUpButton(){
        self.delegate?.actionSignUpButton()
    }
    
    @objc
    private func tappedLoginPageButton(){
        self.delegate?.actionGoToLoginButton()
    }
    
    //MARK: - Methods
    
    private func configBackground() {
        self.backgroundColor = .white
    }
    
    private func configSuperView(){
        self.addSubview(self.animationUIView)
        animationUIView.addSubview(animationView)
        self.addSubview(self.signUpLabel)
        self.addSubview(self.nameTextField)
        self.addSubview(self.nameErrorLabel)
        self.addSubview(self.surnameTextField)
        self.addSubview(self.surnameErrorLabel)
        self.addSubview(self.emailTextField)
        self.addSubview(self.emailErrorLabel)
        self.addSubview(self.passwordTextField)
        self.addSubview(self.passwordErrorLabel)
        self.addSubview(self.confirmPasswordTextField)
        self.addSubview(self.confirmPasswordErrorLabel)
        self.addSubview(self.signUpButton)
        self.addSubview(self.alreadyMemberLabel)
    }
    
    //Hides error label when pages shows up
    func errorMessagesHidden(){
        self.nameErrorLabel.isHidden = true
        self.surnameErrorLabel.isHidden = true
        self.passwordErrorLabel.isHidden = true
        self.emailErrorLabel.isHidden = true
        self.confirmPasswordErrorLabel.isHidden = true
    }
    
    public func getEmail()->String{
        return self.emailTextField.text ?? ""
    }
    
    public func getPassword()->String{
        return self.passwordTextField.text ?? ""
    }
    
    public func configTextFieldDelegate(delegate:UITextFieldDelegate) {
        self.emailTextField.delegate = delegate
        self.passwordTextField.delegate = delegate
    }
    

    
    private func configConstraints(){
        self.setUpAnimationUIView()
        self.setUpSignLabel()
        self.setUpNameTextField()
        self.setUpNameErrorLabel()
        self.setUpSurnameTextField()
        self.setUpSurnameErrorLabel()
        self.setUpEmailTextField()
        self.setUpEmailErrorLabel()
        self.setUpPasswordTextField()
        self.setUpPasswordErrorLabel()
        self.setUpConfirmPasswordTextField()
        self.setUpConfirmPasswordErrorLabel()
        self.setUpSignUpButton()
        self.setUpAlreadyMemberLabel()
        self.configAlreadyMember()
    }
    
    private func setUpAnimationUIView() {
        NSLayoutConstraint.activate([
            self.animationUIView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20),
            self.animationUIView.bottomAnchor.constraint(equalTo: signUpLabel.topAnchor, constant: -15),
            self.animationUIView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            self.animationUIView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15),
            self.animationUIView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.25),
            
            self.animationView.topAnchor.constraint(equalTo: animationUIView.safeAreaLayoutGuide.topAnchor),
            self.animationView.bottomAnchor.constraint(equalTo: animationUIView.safeAreaLayoutGuide.bottomAnchor),
            self.animationView.leadingAnchor.constraint(equalTo: animationUIView.safeAreaLayoutGuide.leadingAnchor),
            self.animationView.trailingAnchor.constraint(equalTo: animationUIView.safeAreaLayoutGuide.trailingAnchor)
            ])
    }

    private func setUpSignLabel() {
        NSLayoutConstraint.activate([
            self.signUpLabel.bottomAnchor.constraint(equalTo: nameTextField.topAnchor, constant: -10),
            self.signUpLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            self.signUpLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15)
            ])
    }
    
    private func setUpNameTextField() {
        NSLayoutConstraint.activate([
            self.nameTextField.bottomAnchor.constraint(equalTo: nameErrorLabel.topAnchor, constant: -1),
            self.nameTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            self.nameTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15)
            ])
    }
    
    private func setUpNameErrorLabel() {
            NSLayoutConstraint.activate([
                self.nameErrorLabel.bottomAnchor.constraint(equalTo: surnameTextField.topAnchor, constant: -1),
                self.nameErrorLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 17),
                self.nameErrorLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15)
                ])
        }
    
    private func setUpSurnameTextField() {
        NSLayoutConstraint.activate([
            self.surnameTextField.bottomAnchor.constraint(equalTo: surnameErrorLabel.topAnchor, constant: -1),
            self.surnameTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            self.surnameTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15)
            ])
    }
    
    private func setUpSurnameErrorLabel() {
            NSLayoutConstraint.activate([
                self.surnameErrorLabel.bottomAnchor.constraint(equalTo: emailTextField.topAnchor, constant: -1),
                self.surnameErrorLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 17),
                self.surnameErrorLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15)
                ])
        }
    
    private func setUpEmailTextField() {
        NSLayoutConstraint.activate([
            self.emailTextField.bottomAnchor.constraint(equalTo: emailErrorLabel.topAnchor, constant: -1),
            self.emailTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            self.emailTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15)
            ])
    }
    
    private func setUpEmailErrorLabel() {
            NSLayoutConstraint.activate([
                self.emailErrorLabel.bottomAnchor.constraint(equalTo: passwordTextField.topAnchor, constant: -1),
                self.emailErrorLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 17),
                self.emailErrorLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15)
                ])
        }
    
    private func setUpPasswordTextField() {
        NSLayoutConstraint.activate([
            self.passwordTextField.bottomAnchor.constraint(equalTo: passwordErrorLabel.topAnchor, constant: -1),
            self.passwordTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            self.passwordTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15)
            ])
    }
    
    private func setUpPasswordErrorLabel() {
            NSLayoutConstraint.activate([
                self.passwordErrorLabel.bottomAnchor.constraint(equalTo: confirmPasswordTextField.topAnchor, constant: -1),
                self.passwordErrorLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 17),
                self.passwordErrorLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15)
                ])
        }
  
    private func setUpConfirmPasswordTextField() {
        NSLayoutConstraint.activate([
            self.confirmPasswordTextField.bottomAnchor.constraint(equalTo: confirmPasswordErrorLabel.topAnchor, constant: -1),
            self.confirmPasswordTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            self.confirmPasswordTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15)
            ])
    }
    
    private func setUpConfirmPasswordErrorLabel() {
            NSLayoutConstraint.activate([
               // self.confirmPasswordErrorLabel.bottomAnchor.constraint(equalTo: signUpButton.topAnchor, constant: -20),
                self.confirmPasswordErrorLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 17),
                self.confirmPasswordErrorLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15)
                ])
        }
    
    private func setUpSignUpButton() {
        NSLayoutConstraint.activate([
            self.signUpButton.bottomAnchor.constraint(equalTo: alreadyMemberLabel.topAnchor, constant: -20),
            self.signUpButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            self.signUpButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            self.signUpButton.heightAnchor.constraint(equalToConstant: 40)
            ])
    }
    
    private func setUpAlreadyMemberLabel() {
        NSLayoutConstraint.activate([
            self.alreadyMemberLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20),
            self.alreadyMemberLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor)
            ])
    }
    
    fileprivate func configAlreadyMember() {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.34
        
        let font: UIFont = .systemFont(ofSize: 12)
        let boldFont: UIFont = .boldSystemFont(ofSize: 12)
        
        let baseString = NSMutableAttributedString(string: LC.alreadyMember.text,
                                                   attributes: [NSAttributedString.Key.paragraphStyle : paragraphStyle,
                                                    NSAttributedString.Key.font : font])
        
        let linkString = NSMutableAttributedString(string: LC.login.text, attributes: [NSAttributedString.Key.paragraphStyle : paragraphStyle,
             NSAttributedString.Key.font : boldFont,
             NSAttributedString.Key.link : tappedLoginPageButton
                                                                                    ])
        
        let tapButton = UITapGestureRecognizer(target: self, action: #selector(tappedLoginPageButton))
        alreadyMemberLabel.addGestureRecognizer(tapButton)
        
        baseString.append(linkString)
        
        alreadyMemberLabel.linkTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.systemBlue,
            NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue,
            NSAttributedString.Key.underlineColor: UIColor.systemBlue
        ]

        alreadyMemberLabel.attributedText = baseString
    }

}
