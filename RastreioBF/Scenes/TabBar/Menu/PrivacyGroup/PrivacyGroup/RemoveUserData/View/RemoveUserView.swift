//
//  MeusDadosScreen.swift
//  BackFrontProject
//
//  Created by ALYSSON MENEZES on 25/08/22.
//

import UIKit

protocol RemoveUserScreenProtocol: AnyObject {
    func actionBackButton()
    func actionRegisterButton()
}

class RemoveUserView: UIView {
    
    weak private var delegate: RemoveUserScreenProtocol?
    
    func delegate(delegate: RemoveUserScreenProtocol?) {
        self.delegate = delegate
    }
    
    lazy var backButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "back"), for: .normal)
        button.addTarget(self, action: #selector(self.tappedBackButton), for: .touchUpInside)
        return button
    }()
    
    lazy var removeDadosLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(named: "mainPurpleColor")
        label.font = UIFont.boldSystemFont(ofSize: 40)
        label.text = "Remover Conta"
        return label
    }()
    
    lazy var logoAppImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "removeUser" )
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    lazy var tableView: UITableView = {
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

    lazy var registerButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Remover", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.clipsToBounds = true
        button.layer.cornerRadius = 9
        button.backgroundColor = UIColor(named: "mainPurpleColor")
        button.addTarget(self, action: #selector(tappedRegisterButton), for: .touchUpInside)
        return button
    }()
    
    private func configBackGround() {
        backgroundColor = .white
    }
    
    @objc private func tappedBackButton() {
        delegate?.actionBackButton()
    }
    
    private func configSuperView() {
        addSubview(backButton)
        addSubview(removeDadosLabel)
        addSubview(tableView)
        addSubview(logoAppImageView)
        addSubview(registerButton)
        tableView.addSubview(registerButton)
        tableView.addSubview(removeDadosLabel)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configBackGround()
        configSuperView()
        configConstraints()
    }
    
    @objc private func tappedRegisterButton() {
        delegate?.actionRegisterButton()
    }
    
    public func configTableViewProtocols(delegate: UITableViewDelegate, dataSource: UITableViewDataSource) {
        tableView.delegate = delegate
        tableView.dataSource = dataSource
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configButtonEnable(_ enable : Bool ) {
        if enable {
            registerButton.setTitleColor(.white, for: .normal)
            registerButton.isEnabled = true
        } else {
            registerButton.setTitleColor(.lightGray, for: .normal)
            registerButton.isEnabled = false
        }
    }
    
    private func configConstraints() {
        
        NSLayoutConstraint.activate([
            
            backButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10),
            backButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor,constant: 20),
            
            tableView.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            tableView.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
            
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            tableView.heightAnchor.constraint(equalToConstant: 500),
            
            removeDadosLabel.centerXAnchor.constraint(equalTo: tableView.centerXAnchor),
            removeDadosLabel.topAnchor.constraint(equalTo: tableView.topAnchor, constant: 35),
            
            logoAppImageView.centerXAnchor.constraint(equalTo: tableView.centerXAnchor, constant: 20),
            logoAppImageView.centerYAnchor.constraint(equalTo: tableView.centerYAnchor ),
            logoAppImageView.heightAnchor.constraint(equalToConstant: 150),
            
            registerButton.centerXAnchor.constraint(equalTo: tableView.centerXAnchor),
            
            registerButton.topAnchor.constraint(equalTo: logoAppImageView.bottomAnchor, constant: 80),
            registerButton.leadingAnchor.constraint(equalTo: tableView.leadingAnchor, constant: 35),
            registerButton.trailingAnchor.constraint(equalTo: tableView.trailingAnchor, constant: -35)

        ])
    }
}


