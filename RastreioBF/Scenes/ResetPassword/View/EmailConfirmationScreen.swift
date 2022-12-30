//
//  EmailConfirmationView.swift
//  RastreioBF
//
//  Created by Jessica Bigal on 09/09/22.
//

import UIKit
import Lottie
import UIKit.UITextField
import Foundation

class EmailConfirmationScreen: UIView {
    
    // MARK: - Delegate
    private var shouldFocusLink: Bool = false
    weak var delegate: EmailConfirmationScreenDelegate?
    
    // MARK: - UI Properties
    
    lazy var backButton: UIButton = {
        var button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: LC.backBt.text), for: .normal)
        button.tintColor = .black
        button.contentMode = .scaleAspectFit
        button.translatesAutoresizingMaskIntoConstraints = false
        button.imageView?.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(tappedBack), for: .touchUpInside)
        return button
    }()
    
    lazy var animationUIView:UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var animationView:AnimationView = {
        var animation = AnimationView()
        animation = .init(name: LC.unlocked.text)
        animation.contentMode = .scaleAspectFill
        animation.loopMode = .playOnce
        animation.animationSpeed = 0.5
        animation.translatesAutoresizingMaskIntoConstraints = false
        animation.play()
        return animation
    }()
    
    lazy var emailConfirmationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(named: LC.titlesColor.text)
        label.font = UIFont.preferredFont(forTextStyle: .callout)
        label.font = .systemFont(ofSize: 25, weight: .semibold)
        label.text = LC.insertRegisteredEmail.text
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
        text.returnKeyType = UIReturnKeyType.done
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
    
    lazy var confirmationCodeButton: UIButton = {
        var button = UIButton(type: .roundedRect)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(LC.sendEmailTextButton.text, for: .normal)
        button.titleLabel?.textAlignment = .center
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 8
        button.tintColor = .white
        button.addTarget(self, action: #selector(tappedConfirmCodeButton), for: .touchUpInside)
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
        self.configBackground()
        self.configSuperView()
        self.setUpConstraints()
        self.setUpRegister()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configBackground() {
        self.backgroundColor = .white
    }
    
    @objc
    private func tappedBack() {
        delegate?.actionGoBackTapped()
    }
    
    @objc
    private func tappedEmail() {
        delegate?.didTapEmailTapped()
    }
    
    @objc
    func tappedConfirmCodeButton() {
        delegate?.actionGoToCodeButtonTapped()
    }
    
    @objc
    private func tappedRegisterButton() {
        delegate?.actionSignUpButtonTapped()
    }
    
    func configSuperView(){
        addSubview(backButton)
        addSubview(animationUIView)
        animationUIView.addSubview(animationView)
        addSubview(emailConfirmationLabel)
        addSubview(emailTextField)
        addSubview(emailErrorLabel)
        addSubview(confirmationCodeButton)
        addSubview(registerLabel)
    }
    
    func setUpConstraints(){
        setUpBackButton()
        setUpAnimationUIView()
        setUpEmailCodeLabel()
        setUpEmailTextField()
        setUpEmailErrorLabel()
        setUpConfirmationButton()
        setUpRegisterLabel()
    }
    
    private func setUpBackButton(){
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20),
            backButton.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            backButton.heightAnchor.constraint(equalToConstant: 24),
            backButton.widthAnchor.constraint(equalToConstant: 24)
        ])
    }
    
    private func setUpAnimationUIView() {
        NSLayoutConstraint.activate([
            animationUIView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 30),
            animationUIView.bottomAnchor.constraint(equalTo: emailConfirmationLabel.topAnchor, constant: -25),
            animationUIView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 25),
            animationUIView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15),
            animationUIView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.45),
            
            animationView.topAnchor.constraint(equalTo: animationUIView.safeAreaLayoutGuide.topAnchor),
            animationView.bottomAnchor.constraint(equalTo: animationUIView.safeAreaLayoutGuide.bottomAnchor),
            animationView.leadingAnchor.constraint(equalTo: animationUIView.safeAreaLayoutGuide.leadingAnchor),
            animationView.trailingAnchor.constraint(equalTo: animationUIView.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    private func setUpEmailCodeLabel() {
        NSLayoutConstraint.activate([
            emailConfirmationLabel.bottomAnchor.constraint(equalTo: emailTextField.topAnchor, constant: -10),
            emailConfirmationLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            emailConfirmationLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15)
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
            emailErrorLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 17),
            emailErrorLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15)
        ])
    }
    
    private func setUpConfirmationButton() {
        NSLayoutConstraint.activate([
            confirmationCodeButton.topAnchor.constraint(equalTo: emailErrorLabel.bottomAnchor, constant: 15),
            confirmationCodeButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            confirmationCodeButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            confirmationCodeButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func setUpRegisterLabel() {
        NSLayoutConstraint.activate([
            registerLabel.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -25),
            registerLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor)
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
