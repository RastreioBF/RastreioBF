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

class SignUpView: UIView {
    
    var hasNameLabel: Bool {
        get { nameErrorLabel.isHidden }
    }
    
    var hasNameTextField: Bool {
        get { nameTextField.hasText }
    }
    
    var hasSurnameLabel: Bool {
        get { surnameErrorLabel.isHidden }
    }
    
    var hasSurnameTextField: Bool {
        get { surnameTextField.hasText }
    }
    
    var hasEmailLabel: Bool {
        get { emailErrorLabel.isHidden }
    }
    
    var hasEmailTextField: Bool {
        get { emailTextField.hasText }
    }
    
    var hasPasswordLabel: Bool {
        get { passwordErrorLabel.isHidden }
    }
    
    var hasPasswordTextField: Bool {
        get { passwordTextField.hasText }
    }
    
    var hasConfPasswordLabel: Bool {
        get { confirmPasswordErrorLabel.isHidden }
    }
    
    var hasConfPasswordTextField: Bool {
        get { confirmPasswordTextField.hasText }
    }
    
    // MARK: - Delegate
    private var shouldFocusLink: Bool = false
    weak var delegate:SignUpViewProtocol?
    
    func delegate(delegate:SignUpViewProtocol?) {
        self.delegate = delegate
    }
    
    // MARK: - UI Properties
    
    lazy var animationUIView:UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var animationView:AnimationView = {
        var animation = AnimationView()
        animation = .init(name: LC.signUpAnimation.text)
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
        label.textColor = UIColor(named: LC.titlesColor.text)
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
        text.keyboardType = UIKeyboardType.alphabet
        text.returnKeyType = UIReturnKeyType.continue
        text.autocorrectionType = .no
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
        text.keyboardType = UIKeyboardType.alphabet
        text.returnKeyType = UIReturnKeyType.continue
        text.clearButtonMode = UITextField.ViewMode.whileEditing
        text.placeholder = LC.surnamePlaceHolder.text
        text.autocorrectionType = .no
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
        text.autocorrectionType = .no
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
        text.autocorrectionType = .no
        text.keyboardType = UIKeyboardType.default
        text.isSecureTextEntry = false
        text.returnKeyType = UIReturnKeyType.continue
        text.disableAutoFill()
        text.addTarget(self, action: #selector(tappedPassword), for: .editingChanged)
        text.textContentType = .oneTimeCode
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
        text.autocorrectionType = .no
        text.borderStyle = UITextField.BorderStyle.roundedRect
        text.keyboardType = UIKeyboardType.default
        text.isSecureTextEntry = false
        text.textContentType = .oneTimeCode
        text.returnKeyType = UIReturnKeyType.done
        text.disableAutoFill()
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
        delegate?.didTapName()
    }
    
    @objc
    private func tappedSurname(){
        delegate?.didTapSurname()
    }
    
    @objc
    private func tappedEmail(){
        delegate?.didTapEmail()
    }
    
    @objc
    private func tappedPassword(){
        delegate?.didTapPassword()
    }
    
    @objc
    private func tappedConfirmPassword(){
        delegate?.didTapConfirmPassword()
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
        addSubview(self.animationUIView)
        animationUIView.addSubview(animationView)
        addSubview(self.signUpLabel)
        addSubview(self.nameTextField)
        addSubview(self.nameErrorLabel)
        addSubview(self.surnameTextField)
        addSubview(self.surnameErrorLabel)
        addSubview(self.emailTextField)
        addSubview(self.emailErrorLabel)
        addSubview(self.passwordTextField)
        addSubview(self.passwordErrorLabel)
        addSubview(self.confirmPasswordTextField)
        addSubview(self.confirmPasswordErrorLabel)
        addSubview(self.signUpButton)
        addSubview(self.alreadyMemberLabel)
    }
    
    func errorMessagesHidden(){
        nameErrorLabel.isHidden = true
        surnameErrorLabel.isHidden = true
        passwordErrorLabel.isHidden = true
        emailErrorLabel.isHidden = true
        confirmPasswordErrorLabel.isHidden = true
    }
    
    public func getEmail()->String{
        return emailTextField.text ?? ""
    }
    
    public func getPassword()->String{
        return passwordTextField.text ?? ""
    }
    
    private func configConstraints(){
        setUpAnimationUIView()
        setUpSignLabel()
        setUpNameTextField()
        setUpNameErrorLabel()
        setUpSurnameTextField()
        setUpSurnameErrorLabel()
        setUpEmailTextField()
        setUpEmailErrorLabel()
        setUpPasswordTextField()
        setUpPasswordErrorLabel()
        setUpConfirmPasswordTextField()
        setUpConfirmPasswordErrorLabel()
        setUpSignUpButton()
        setUpAlreadyMemberLabel()
        configAlreadyMember()
    }
    
    private func setUpAnimationUIView() {
        NSLayoutConstraint.activate([
            animationUIView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20),
            animationUIView.bottomAnchor.constraint(equalTo: signUpLabel.topAnchor, constant: -15),
            animationUIView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            animationUIView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15),
            animationUIView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.25),
            
            animationView.topAnchor.constraint(equalTo: animationUIView.safeAreaLayoutGuide.topAnchor),
            animationView.bottomAnchor.constraint(equalTo: animationUIView.safeAreaLayoutGuide.bottomAnchor),
            animationView.leadingAnchor.constraint(equalTo: animationUIView.safeAreaLayoutGuide.leadingAnchor),
            animationView.trailingAnchor.constraint(equalTo: animationUIView.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    private func setUpSignLabel() {
        NSLayoutConstraint.activate([
            signUpLabel.bottomAnchor.constraint(equalTo: nameTextField.topAnchor, constant: -10),
            signUpLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            signUpLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15)
        ])
    }
    
    private func setUpNameTextField() {
        NSLayoutConstraint.activate([
            nameTextField.bottomAnchor.constraint(equalTo: nameErrorLabel.topAnchor, constant: -1),
            nameTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            nameTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15)
        ])
    }
    
    private func setUpNameErrorLabel() {
        NSLayoutConstraint.activate([
            nameErrorLabel.bottomAnchor.constraint(equalTo: surnameTextField.topAnchor, constant: -1),
            nameErrorLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 17),
            nameErrorLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15)
        ])
    }
    
    private func setUpSurnameTextField() {
        NSLayoutConstraint.activate([
            surnameTextField.bottomAnchor.constraint(equalTo: surnameErrorLabel.topAnchor, constant: -1),
            surnameTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            surnameTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15)
        ])
    }
    
    private func setUpSurnameErrorLabel() {
        NSLayoutConstraint.activate([
            surnameErrorLabel.bottomAnchor.constraint(equalTo: emailTextField.topAnchor, constant: -1),
            surnameErrorLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 17),
            surnameErrorLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15)
        ])
    }
    
    private func setUpEmailTextField() {
        NSLayoutConstraint.activate([
            emailTextField.bottomAnchor.constraint(equalTo: emailErrorLabel.topAnchor, constant: -1),
            emailTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            emailTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15)
        ])
    }
    
    private func setUpEmailErrorLabel() {
        NSLayoutConstraint.activate([
            emailErrorLabel.bottomAnchor.constraint(equalTo: passwordTextField.topAnchor, constant: -1),
            emailErrorLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 17),
            emailErrorLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15)
        ])
    }
    
    private func setUpPasswordTextField() {
        NSLayoutConstraint.activate([
            passwordTextField.bottomAnchor.constraint(equalTo: passwordErrorLabel.topAnchor, constant: -1),
            passwordTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            passwordTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15)
        ])
    }
    
    private func setUpPasswordErrorLabel() {
        NSLayoutConstraint.activate([
            passwordErrorLabel.bottomAnchor.constraint(equalTo: confirmPasswordTextField.topAnchor, constant: -1),
            passwordErrorLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 17),
            passwordErrorLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15)
        ])
    }
    
    private func setUpConfirmPasswordTextField() {
        NSLayoutConstraint.activate([
            confirmPasswordTextField.bottomAnchor.constraint(equalTo: confirmPasswordErrorLabel.topAnchor, constant: -1),
            confirmPasswordTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            confirmPasswordTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15)
        ])
    }
    
    private func setUpConfirmPasswordErrorLabel() {
        NSLayoutConstraint.activate([
            confirmPasswordErrorLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 17),
            confirmPasswordErrorLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15)
        ])
    }
    
    private func setUpSignUpButton() {
        NSLayoutConstraint.activate([
            signUpButton.topAnchor.constraint(equalTo: confirmPasswordErrorLabel.topAnchor, constant: 25),
            signUpButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            signUpButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            signUpButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func setUpAlreadyMemberLabel() {
        NSLayoutConstraint.activate([
            alreadyMemberLabel.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            alreadyMemberLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor)
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

extension UITextField {
    func disableAutoFill() {
        if #available(iOS 12, *) {
            textContentType = .oneTimeCode
        } else {
            textContentType = .init(rawValue: "")
        }
    }
}
