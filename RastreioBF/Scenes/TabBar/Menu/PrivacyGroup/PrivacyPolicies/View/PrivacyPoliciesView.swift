//
//  PrivacyPolicyScreen.swift
//  BackFrontProject
//
//  Created by ALYSSON MENEZES on 29/08/22.
//

import Foundation
import UIKit

protocol PrivacyPoliciesViewProtocol: AnyObject {
    func actionBackButton()
}

class PrivacyPoliciesView: UIView {
    
    weak private var delegate: PrivacyPoliciesViewProtocol?
    
    func delegate(delegate: PrivacyPoliciesViewProtocol?) {
        self.delegate = delegate
    }
    
    lazy var backButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: LC.backButton.text), for: .normal)
        button.addTarget(self, action: #selector(tappedBackButton), for: .touchUpInside)
        return button
    }()
    
    lazy var loginLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    lazy var privacyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.backgroundColor = .white
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    private func configBackground() {
        self.backgroundColor = .white
    }
    
    @objc private func tappedBackButton() {
        self.delegate?.actionBackButton()
    }
    
    override init(frame: CGRect) {
        super.init( frame: frame)
        configBackground()
        configSuperView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configSuperView() {
        addSubview(backButton)
        addSubview(privacyLabel)
        addSubview(loginLabel)
        addSubview(loginLabel)
        addSubview(privacyLabel)
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            
            backButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10),
            backButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor,constant: 20),
            
            loginLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            loginLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            loginLabel.heightAnchor.constraint(equalToConstant: 30),
            
            privacyLabel.topAnchor.constraint(equalTo: loginLabel.bottomAnchor, constant: 10),
            privacyLabel.centerXAnchor.constraint(equalTo: privacyLabel.centerXAnchor),
            privacyLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            privacyLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        ])
    }
}
