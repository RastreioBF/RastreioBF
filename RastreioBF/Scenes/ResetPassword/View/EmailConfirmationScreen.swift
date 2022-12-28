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
    var delegate: EmailConfirmationScreenDelegate?
    
    // MARK: - UI Properties
    
    var backButton: UIButton = {
        var button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
        button.tintColor = .black
        button.contentMode = .scaleAspectFit
        button.translatesAutoresizingMaskIntoConstraints = false
        button.imageView?.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(tappedBack), for: .touchUpInside)
        return button
    }()
    
    var animationUIView:UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var animationView:AnimationView = {
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
        self.delegate?.actionGoBackTapped()
    }
    
    @objc
    private func tappedEmail() {
        self.delegate?.didTapEmailTapped()
    }
    
    @objc
    func tappedConfirmCodeButton() {
        self.delegate?.actionGoToCodeButtonTapped()
    }
    
    @objc
    private func tappedRegisterButton() {
        self.delegate?.actionSignUpButtonTapped()
    }
    
    func configSuperView(){
        self.addSubview(backButton)
        self.addSubview(animationUIView)
        animationUIView.addSubview(animationView)
        self.addSubview(emailConfirmationLabel)
        self.addSubview(emailTextField)
        self.addSubview(emailErrorLabel)
        self.addSubview(confirmationCodeButton)
        self.addSubview(registerLabel)
    }
    
    func setUpConstraints(){
        self.setUpBackButton()
        self.setUpAnimationUIView()
        self.setUpEmailCodeLabel()
        self.setUpEmailTextField()
        self.setUpEmailErrorLabel()
        self.setUpConfirmationButton()
        self.setUpRegisterLabel()
    }
    
    private func setUpBackButton(){
        NSLayoutConstraint.activate([
            self.backButton.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20),
            self.backButton.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            self.backButton.heightAnchor.constraint(equalToConstant: 24),
            self.backButton.widthAnchor.constraint(equalToConstant: 24)
        ])
    }
    
    private func setUpAnimationUIView() {
        NSLayoutConstraint.activate([
            self.animationUIView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 30),
            self.animationUIView.bottomAnchor.constraint(equalTo: emailConfirmationLabel.topAnchor, constant: -25),
            self.animationUIView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 25),
            self.animationUIView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15),
            self.animationUIView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.45),
            
            self.animationView.topAnchor.constraint(equalTo: animationUIView.safeAreaLayoutGuide.topAnchor),
            self.animationView.bottomAnchor.constraint(equalTo: animationUIView.safeAreaLayoutGuide.bottomAnchor),
            self.animationView.leadingAnchor.constraint(equalTo: animationUIView.safeAreaLayoutGuide.leadingAnchor),
            self.animationView.trailingAnchor.constraint(equalTo: animationUIView.safeAreaLayoutGuide.trailingAnchor)
            ])
    }

    private func setUpEmailCodeLabel() {
        NSLayoutConstraint.activate([
            self.emailConfirmationLabel.bottomAnchor.constraint(equalTo: emailTextField.topAnchor, constant: -10),
            self.emailConfirmationLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            self.emailConfirmationLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15)
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
//                self.emailErrorLabel.bottomAnchor.constraint(equalTo: passwordTextField.topAnchor, constant: -1),
                self.emailErrorLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 17),
                self.emailErrorLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15)
                ])
        }
    
    private func setUpConfirmationButton() {
        NSLayoutConstraint.activate([
            self.confirmationCodeButton.topAnchor.constraint(equalTo: emailErrorLabel.bottomAnchor, constant: 15),
            self.confirmationCodeButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            self.confirmationCodeButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            self.confirmationCodeButton.heightAnchor.constraint(equalToConstant: 40)
            ])
    }
    
    private func setUpRegisterLabel() {
        NSLayoutConstraint.activate([
            self.registerLabel.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -25),
            self.registerLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor)
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
