//
//  TrackingScreen.swift
//  RastreioBF
//
//  Created by Jessica Bigal on 11/09/22.
//

import UIKit

protocol TrackingScreenProtocol: AnyObject {
    func actionBackButton()
    func actionSubmitButton()
    func actionEmailNotificationSwitch()
    func actionSendNoticationToAnotherEmailButton()
}

class TrackingScreen: UIView {
    
    weak var delegate: TrackingScreenProtocol?
    
    func delegate(delegate: TrackingScreenProtocol?){
        self.delegate = delegate
    }
    
//    lazy var backButton: UIButton = {
//        let button = UIButton()
//        button.translatesAutoresizingMaskIntoConstraints = false
//        button.setImage(UIImage(named: "back"), for: .normal)
//        button.addTarget(self, action: #selector(self.tappedBackButton), for: .touchUpInside)
//        return button
//    }()
//
//    lazy var trackingLabel: UILabel = {
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.font = UIFont.preferredFont(forTextStyle: .callout)
//        label.font = .systemFont(ofSize: 25, weight: .semibold)
//        label.text = "Novo Rastreio"
//        label.textAlignment = .center
//        return label
//    }()
//
//    lazy var imageAddUser: UIImageView = {
//        let image = UIImageView()
//        image.translatesAutoresizingMaskIntoConstraints = false
//        image.image = UIImage(named: "logoImage")
//        image.contentMode = .scaleAspectFit
//        return image
//    }()
    
    lazy var instructionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.preferredFont(forTextStyle: .callout)
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.text = "Preencha os campos abaixo com as informações do objeto que deseja rastrear"
        label.numberOfLines = 0
        return label
    }()
    
    lazy var trackingNumberLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .callout)
        label.font = .systemFont(ofSize: 16, weight: .light)
        label.text = "Código de Rastreio"
        label.textAlignment = .left
        return label
    }()
    
    lazy var trackingNumberTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.autocorrectionType = .no
        textField.backgroundColor = .white
        textField.borderStyle = .roundedRect
        textField.keyboardType = .default
        textField.placeholder = "Insira seu número de rastreio..."
        textField.font = UIFont.systemFont(ofSize: 14)
        textField.textColor = .darkGray
        return textField
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .callout)
        label.font = .systemFont(ofSize: 16, weight: .light)
        label.text = "Descrição"
        label.textAlignment = .left
        return label
    }()
    
    lazy var descriptionTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.autocorrectionType = .no
        textField.backgroundColor = .white
        textField.borderStyle = .roundedRect
        textField.keyboardType = .default
        textField.placeholder = "Insira uma descrição..."
        textField.font = UIFont.systemFont(ofSize: 14)
        textField.textColor = .darkGray
        return textField
    }()
    
    lazy var getEmailNotificationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .callout)
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .darkGray
        label.text = "Notificação por email"
        label.textAlignment = .left
        return label
    }()
    
    lazy var emailNotificationSwitch: UISwitch = {
        let mySwitch = UISwitch()
        mySwitch.translatesAutoresizingMaskIntoConstraints = false
        mySwitch.isOn = false
        mySwitch.onTintColor = .green
        mySwitch.addTarget(self, action: #selector(self.tappedEmailNotificationSwitch(sender:)), for: .touchUpInside)
        return mySwitch
    }()
    
    lazy var sendNoticationToAnotherEmailButton: UIButton = {
        var button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Enviar notificação para outro email", for: .normal)
        button.titleLabel?.textAlignment = .left
        button.setTitleColor(UIColor.systemBlue, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.addTarget(self, action: #selector(self.tappedSendNoticationToAnotherEmailButton), for: .touchUpInside)
        return button
    }()
    
    lazy var submitButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Salvar", for: .normal)
        button.titleLabel?.textAlignment = .center
        button.backgroundColor = UIColor(named: "mainPurpleColor")
        button.layer.cornerRadius = 8
        button.titleLabel?.font = UIFont(name: "", size: 12)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(self.tappedSubmitButton), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configBackground()
        self.configSuperView()
        self.setUpConstraints()
        configButtonEnabled(false)
    }
    
    private func configSuperView(){
//        self.addSubview(self.trackingLabel)
//        self.addSubview(self.backButton)
//        self.addSubview(self.imageAddUser)
        self.addSubview(self.instructionLabel)
        self.addSubview(self.trackingNumberLabel)
        self.addSubview(self.trackingNumberTextField)
        self.addSubview(self.descriptionLabel)
        self.addSubview(self.descriptionTextField)
        self.addSubview(self.getEmailNotificationLabel)
        self.addSubview(self.emailNotificationSwitch)
        self.addSubview(self.sendNoticationToAnotherEmailButton)
        self.addSubview(self.submitButton)
        
    }
        
    private func configBackground(){
        self.backgroundColor = .white
    }
    
    public func configTextFieldDelegate(delegate: UITextFieldDelegate){
        self.trackingNumberTextField.delegate = delegate
        self.descriptionTextField.delegate = delegate
    }
    
    @objc private func tappedBackButton(){
        self.delegate?.actionBackButton()
    }
    
    @objc private func tappedSubmitButton(){
        self.delegate?.actionSubmitButton()
    }
    
    @objc func tappedEmailNotificationSwitch(sender: UISwitch) {
        self.delegate?.actionEmailNotificationSwitch()
    }
    
    @objc private func tappedSendNoticationToAnotherEmailButton(){
        self.delegate?.actionSendNoticationToAnotherEmailButton()
    }
    
    public func validateTextFields(){
        let trackingNumber: String = self.trackingNumberTextField.text ?? ""
        let description: String = self.descriptionTextField.text ?? ""
        
        if !trackingNumber.isEmpty && !description.isEmpty {
            self.configButtonEnabled(true)
        } else{
            self.configButtonEnabled(false)
        }
    }
    
    private func configButtonEnabled(_ enable: Bool){
        if enable {
            self.submitButton.setTitleColor(.lightGray, for: .normal)
            self.submitButton.isEnabled = true
        } else {
            self.submitButton.setTitleColor(.white, for: .normal)
            self.submitButton.isEnabled = false
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpConstraints(){
        NSLayoutConstraint.activate([
            
//            self.trackingLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 5),
//            self.trackingLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
//            self.trackingLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
//            self.trackingLabel.heightAnchor.constraint(equalToConstant: 40),
//
//            self.backButton.topAnchor.constraint(equalTo: self.trackingLabel.topAnchor),
//            self.backButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
//
//            self.imageAddUser.topAnchor.constraint(equalTo: self.trackingLabel.bottomAnchor, constant: 30),
//            self.imageAddUser.centerXAnchor.constraint(equalTo: self.centerXAnchor),
//            self.imageAddUser.widthAnchor.constraint(equalToConstant: 100),
//            self.imageAddUser.heightAnchor.constraint(equalToConstant: 100),
            
            self.instructionLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 30),
            self.instructionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            self.instructionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
//            self.instructionLabel.heightAnchor.constraint(equalToConstant: 40)
            
            self.trackingNumberLabel.topAnchor.constraint(equalTo: self.instructionLabel.bottomAnchor, constant: 30),
            self.trackingNumberLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            self.trackingNumberLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
//            self.trackingNumberLabel.heightAnchor.constraint(equalToConstant: 40),
            
            self.trackingNumberTextField.topAnchor.constraint(equalTo: self.trackingNumberLabel.bottomAnchor, constant: 5),
            self.trackingNumberTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            self.trackingNumberTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
//            self.trackingNumberTextField.heightAnchor.constraint(equalToConstant: 40),
            
            self.descriptionLabel.topAnchor.constraint(equalTo: self.trackingNumberTextField.bottomAnchor, constant: 10),
            self.descriptionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            self.descriptionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
//            self.descriptionLabel.heightAnchor.constraint(equalToConstant: 40),
            
            self.descriptionTextField.topAnchor.constraint(equalTo: self.descriptionLabel.bottomAnchor, constant: 5),
            self.descriptionTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            self.descriptionTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
//            self.descriptionTextField.heightAnchor.constraint(equalToConstant: 40),
            
            self.getEmailNotificationLabel.topAnchor.constraint(equalTo: self.descriptionTextField.bottomAnchor, constant: 15),
            self.getEmailNotificationLabel.leadingAnchor.constraint(equalTo: self.descriptionTextField.leadingAnchor),
            self.getEmailNotificationLabel.trailingAnchor.constraint(equalTo: self.descriptionTextField.trailingAnchor),
//            self.getEmailNotificationLabel.heightAnchor.constraint(equalTo: self.emailNotificationSwitch.heightAnchor),
            
            self.emailNotificationSwitch.topAnchor.constraint(equalTo: self.getEmailNotificationLabel.topAnchor),
            self.emailNotificationSwitch.trailingAnchor.constraint(equalTo: self.descriptionTextField.trailingAnchor),
            
            self.sendNoticationToAnotherEmailButton.topAnchor.constraint(equalTo: self.getEmailNotificationLabel.bottomAnchor, constant: 0),
            self.sendNoticationToAnotherEmailButton.leadingAnchor.constraint(equalTo: self.descriptionTextField.leadingAnchor),
//            self.sendNoticationToAnotherEmailButton.trailingAnchor.constraint(equalTo: self.descriptionTextField.trailingAnchor),
            
            self.submitButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -30),
            self.submitButton.leadingAnchor.constraint(equalTo: self.descriptionTextField.leadingAnchor),
            self.submitButton.trailingAnchor.constraint(equalTo: self.descriptionTextField.trailingAnchor),
            self.submitButton.heightAnchor.constraint(equalToConstant: 40)
        
        ])
    }
}

