//
//  EmailNotificationScreen.swift
//  ViewCodeProject
//
//  Created by Anderson Sales on 11/09/22.
//

import UIKit
import Foundation
import Lottie

protocol EmailNotificationScreenProtocol: AnyObject {
    func actionBackButton()
    func actionConfirmationButton()
    func didTapEmail()
}

class EmailNotificationScreen: UIView {
    
    weak var delegate: EmailNotificationScreenProtocol?
    
    func delegate(delegate: EmailNotificationScreenProtocol?){
        self.delegate = delegate
    }
    
//    lazy var backButton: UIButton = {
//        let button = UIButton()
//        button.translatesAutoresizingMaskIntoConstraints = false
//        button.setImage(UIImage(named: "back"), for: .normal)
//        button.addTarget(self, action: #selector(self.tappedBackButton), for: .touchUpInside)
//        return button
//    }()
    
    var animationUIView:UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var animationView:AnimationView = {
        var animation = AnimationView()
        animation = .init(name:"receiveEmail")
        animation.contentMode = .scaleAspectFill
        animation.loopMode = .playOnce
        animation.animationSpeed = 0.5
        animation.translatesAutoresizingMaskIntoConstraints = false
        animation.play()
        return animation
    }()
    
    lazy var insertEmailLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.text = "Insira seu e-mail"
        label.textColor = UIColor(named: "mainPurpleColor")
        label.textAlignment = .left
        return label
    }()
    
    lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.autocorrectionType = .no
        textField.backgroundColor = .white
        textField.borderStyle = .roundedRect
        textField.keyboardType = .emailAddress
        textField.placeholder = "Digite seu email..."
        textField.font = UIFont.systemFont(ofSize: 14)
        textField.textColor = .darkGray
        textField.addTarget(self, action: #selector(tappedEmail), for: .editingChanged)
        return textField
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
    
    lazy var confirmationButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Salvar", for: .normal)
        button.titleLabel?.textAlignment = .center
        button.backgroundColor = UIColor(named: "mainPurpleColor")
        button.layer.cornerRadius = 8
        button.titleLabel?.font = UIFont(name: "", size: 12)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(self.tappedConfirmationButton), for: .touchUpInside)
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configBackground()
        self.configSuperView()
        self.setUpConstraints()
        self.configButtonEnabled(false)
    }
    
    @objc
    private func tappedEmail(){
        self.delegate?.didTapEmail()
    }
    
    private func configSuperView(){
        self.addSubview(self.animationUIView)
        animationUIView.addSubview(animationView)
        self.addSubview(self.insertEmailLabel)
        self.addSubview(self.emailErrorLabel)
        self.addSubview(self.emailTextField)
        self.addSubview(self.confirmationButton)
    }
    
    
    private func configBackground(){
        self.backgroundColor = .white
    }
    
    public func configTextFieldDelegate(delegate: UITextFieldDelegate){
        self.emailTextField.delegate = delegate
    }
    
    @objc private func tappedBackButton(){
        self.delegate?.actionBackButton()
    }
    
    @objc private func tappedConfirmationButton(){
        self.delegate?.actionConfirmationButton()
    }
    
    public func validateTextFields(){
        let emailField: String = self.emailTextField.text ?? ""
        if !emailField.isEmpty {
            let isEmailAddressValid = isValidEmailAddress(emailAddressString: emailField)
            if isEmailAddressValid {
                self.configButtonEnabled(true)
            }
        } else{
            self.configButtonEnabled(false)
        }
    }
    
    private func configButtonEnabled(_ enable: Bool){
        if enable {
            self.confirmationButton.setTitleColor(.white, for: .highlighted)
            self.confirmationButton.isEnabled = true
        } else {
            self.confirmationButton.setTitleColor(.lightGray, for: .disabled)
            self.confirmationButton.isEnabled = false
        }
    }
    
    private func isValidEmailAddress(emailAddressString: String) -> Bool {
        var returnValue = true
        let emailRegEx = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
            
        do {
            let regex = try NSRegularExpression(pattern: emailRegEx)
            let nsString = emailAddressString as NSString
            let results = regex.matches(in: emailAddressString, range: NSRange(location: 0, length: nsString.length))
                
            if results.count == 0 {
                returnValue = false
            }
        } catch let error as NSError {
            print("invalid regex: \(error.localizedDescription)")
            returnValue = false
        }
        return  returnValue
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpConstraints(){
        NSLayoutConstraint.activate([
        
            self.animationUIView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20),
            self.animationUIView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            self.animationUIView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15),
            self.animationUIView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.5),
            
            self.animationView.topAnchor.constraint(equalTo: animationUIView.safeAreaLayoutGuide.topAnchor),
            self.animationView.bottomAnchor.constraint(equalTo: animationUIView.safeAreaLayoutGuide.bottomAnchor),
            self.animationView.leadingAnchor.constraint(equalTo: animationUIView.safeAreaLayoutGuide.leadingAnchor),
            self.animationView.trailingAnchor.constraint(equalTo: animationUIView.safeAreaLayoutGuide.trailingAnchor),
            
            self.insertEmailLabel.topAnchor.constraint(equalTo: self.animationUIView.bottomAnchor, constant: 5),
            self.insertEmailLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            self.insertEmailLabel.trailingAnchor.constraint(equalTo: self.animationUIView.trailingAnchor),
                        
            self.emailTextField.topAnchor.constraint(equalTo: self.insertEmailLabel.bottomAnchor, constant: 10),
            self.emailTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            self.emailTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            self.emailTextField.bottomAnchor.constraint(equalTo: emailErrorLabel.topAnchor, constant: -1),
//            self.emailTextField.heightAnchor.constraint(equalToConstant: 45),
            
            self.emailErrorLabel.bottomAnchor.constraint(equalTo: confirmationButton.topAnchor, constant: -10),
            self.emailErrorLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 23),
            self.emailErrorLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15),
            
          
            self.confirmationButton.leadingAnchor.constraint(equalTo: self.emailTextField.leadingAnchor),
            self.confirmationButton.trailingAnchor.constraint(equalTo: self.emailTextField.trailingAnchor),
            self.confirmationButton.heightAnchor.constraint(equalToConstant: 40)
        
        
        ])
    }
    
}
