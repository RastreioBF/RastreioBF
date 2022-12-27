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
        button.setImage(UIImage(named: "back"), for: .normal)
        button.addTarget(self, action: #selector(tappedBackButton), for: .touchUpInside)
        return button
    }()
    
    lazy var loginLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(named: "mainPurpleColor")
        label.font = UIFont.boldSystemFont(ofSize: 35)
        label.text = ""
        return label
    }()

    lazy var cardTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .white
        tableView.layer.shadowOffset = CGSize(width: 2, height: 6)
        tableView.layer.masksToBounds=false
        tableView.layer.shadowRadius = 4.0
        tableView.layer.shadowOpacity = 1.0
        tableView.layer.shadowColor=UIColor.gray.cgColor
        tableView.isScrollEnabled = false
        tableView.layer.cornerRadius = 15
        return tableView
    }()
    
    lazy var privacyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.backgroundColor = .white
        label.numberOfLines = 22
        label.textAlignment = NSTextAlignment.justified
        label.text = ""
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
        addSubview(cardTableView)
        addSubview(privacyLabel)
        addSubview(loginLabel)
        cardTableView.addSubview(loginLabel)
        cardTableView.addSubview(privacyLabel)
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            
            backButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10),
            backButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor,constant: 20),
        
            loginLabel.topAnchor.constraint(equalTo: cardTableView.topAnchor, constant: 20),
            loginLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            cardTableView.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            cardTableView.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
            cardTableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            cardTableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            cardTableView.heightAnchor.constraint(equalToConstant: 600),
            
            privacyLabel.topAnchor.constraint(equalTo: loginLabel.bottomAnchor, constant: 20),
            privacyLabel.centerXAnchor.constraint(equalTo: privacyLabel.centerXAnchor),
            privacyLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 35),
            privacyLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -35),
        ])
    }
}
