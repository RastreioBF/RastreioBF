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
    
    private weak var delegate: TrackingViewProtocol?
    
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
        label.text = LC.fillDataMessage.text
        label.numberOfLines = 0
        return label
    }()
    
    lazy var trackingNumberLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .callout)
        label.font = .systemFont(ofSize: 16, weight: .light)
        label.text = LC.trackingCode.text
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
        textField.returnKeyType = UIReturnKeyType.done
        textField.tag = 0
        textField.placeholder = LC.topMessage.text
        textField.clearButtonMode = .whileEditing
        textField.font = UIFont.systemFont(ofSize: 14)
        textField.textColor = .darkGray
        return textField
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .callout)
        label.font = .systemFont(ofSize: 16, weight: .light)
        label.text = LC.descriptionTracking.text
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
        textField.placeholder = LC.insertDescription.text
        textField.font = UIFont.systemFont(ofSize: 14)
        textField.clearButtonMode = .whileEditing
        textField.textColor = .darkGray
        return textField
    }()
    
    lazy var submitButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(LC.saveButton.text, for: .normal)
        button.titleLabel?.textAlignment = .center
        button.backgroundColor = UIColor(named: LC.mainPurpleColor.text)
        button.layer.cornerRadius = 8
        button.titleLabel?.font = UIFont(name: "", size: 12)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(self.tappedSubmitButton), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configBackground()
        configSuperView()
        configConstraints()
    }
    
    private func configSuperView(){
        addSubview(instructionLabel)
        addSubview(trackingNumberLabel)
        addSubview(trackingNumberTextField)
        addSubview(descriptionLabel)
        addSubview(descriptionTextField)
        addSubview(submitButton)
    }
    
    private func configBackground(){
        backgroundColor = .white
    }
    
    func configTextFieldDelegate(delegate: UITextFieldDelegate){
        trackingNumberTextField.delegate = delegate
        descriptionTextField.delegate = delegate
    }
    
    @objc private func tappedBackButton(){
        delegate?.actionBackButton()
    }
    
    @objc private func tappedSubmitButton(){
        delegate?.actionSubmitButton()
    }
    
    private func validateTextFields(){
        let trackingNumber: String = trackingNumberTextField.text ?? ""
        let description: String = descriptionTextField.text ?? ""
        
        if trackingNumber.isEmpty || description.isEmpty || trackingNumber.hasPrefix(" ") || description.hasPrefix(" ") {
            configButtonEnabled(false)
        } else {
            configButtonEnabled(true)
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
    
    private func configConstraints(){
        NSLayoutConstraint.activate([
            
            instructionLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 30),
            instructionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            instructionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            
            descriptionLabel.topAnchor.constraint(equalTo: instructionLabel.bottomAnchor, constant: 50),
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            descriptionTextField.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 5),
            descriptionTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            descriptionTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            trackingNumberLabel.topAnchor.constraint(equalTo: descriptionTextField.bottomAnchor, constant: 10),
            trackingNumberLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            trackingNumberLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            trackingNumberTextField.topAnchor.constraint(equalTo: trackingNumberLabel.bottomAnchor, constant: 5),
            trackingNumberTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            trackingNumberTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            submitButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -30),
            submitButton.leadingAnchor.constraint(equalTo: descriptionTextField.leadingAnchor),
            submitButton.trailingAnchor.constraint(equalTo: descriptionTextField.trailingAnchor),
            submitButton.heightAnchor.constraint(equalToConstant: 40)
            
        ])
    }
}
