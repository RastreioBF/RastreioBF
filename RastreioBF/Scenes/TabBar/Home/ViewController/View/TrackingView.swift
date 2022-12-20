//
//  TrackingView.swift
//  MyProjectScreens
//
//  Created by Anderson Sales on 28/10/22.
//

import UIKit
import Lottie

protocol TrackingViewProtocol: AnyObject {
    func actionBackButton()
    func actionSubmitButton()
}

class TrackingView: UIView {
    
    weak var delegate: TrackingViewProtocol?
    
    func delegate(delegate: TrackingViewProtocol?){
        self.delegate = delegate
    }
    
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
        textField.returnKeyType = UIReturnKeyType.continue
        textField.tag = 0
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
        textField.returnKeyType = UIReturnKeyType.done
        textField.tag = 1
        textField.placeholder = "Insira uma descrição..."
        textField.font = UIFont.systemFont(ofSize: 14)
        textField.textColor = .darkGray
        return textField
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
        self.addSubview(self.instructionLabel)
        self.addSubview(self.trackingNumberLabel)
        self.addSubview(self.trackingNumberTextField)
        self.addSubview(self.descriptionLabel)
        self.addSubview(self.descriptionTextField)
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
    
    public func validateTextFields(){
        let trackingNumber: String = self.trackingNumberTextField.text ?? ""
        let description: String = self.descriptionTextField.text ?? ""
        
        if trackingNumber.isEmpty || description.isEmpty || trackingNumber.hasPrefix(" ") || description.hasPrefix(" ") {
            self.configButtonEnabled(false)
        } else {
            self.configButtonEnabled(true)
        }
    }
    
    private func configButtonEnabled(_ enable: Bool){
        if enable {
            submitButton.setTitleColor(.white, for: .normal)
            submitButton.isEnabled = true
        } else {
            submitButton.setTitleColor(.lightGray, for: .normal)
            submitButton.isEnabled = false
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpConstraints(){
        NSLayoutConstraint.activate([
            
            self.instructionLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 30),
            self.instructionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            self.instructionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            
            self.trackingNumberLabel.topAnchor.constraint(equalTo: self.instructionLabel.bottomAnchor, constant: 50),
            self.trackingNumberLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            self.trackingNumberLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            
            self.trackingNumberTextField.topAnchor.constraint(equalTo: self.trackingNumberLabel.bottomAnchor, constant: 5),
            self.trackingNumberTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            self.trackingNumberTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            
            self.descriptionLabel.topAnchor.constraint(equalTo: self.trackingNumberTextField.bottomAnchor, constant: 10),
            self.descriptionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            self.descriptionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            
            self.descriptionTextField.topAnchor.constraint(equalTo: self.descriptionLabel.bottomAnchor, constant: 5),
            self.descriptionTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            self.descriptionTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            
            self.submitButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -30),
            self.submitButton.leadingAnchor.constraint(equalTo: self.descriptionTextField.leadingAnchor),
            self.submitButton.trailingAnchor.constraint(equalTo: self.descriptionTextField.trailingAnchor),
            self.submitButton.heightAnchor.constraint(equalToConstant: 40)
        
        ])
    }
}

