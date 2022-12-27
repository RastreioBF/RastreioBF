
//
//  MeusDadosScreen.swift
//  BackFrontProject
//
//  Created by ALYSSON MENEZES on 25/08/22.
//

import UIKit

protocol RequestUserDataProtocol: AnyObject {
    func actionBackButton()
    func actionRegisterButton()
}

class  RequestUserDataView: UIView {
    
    weak private var delegate : RequestUserDataProtocol?
    
    func delegate( delegate: RequestUserDataProtocol?) {
        self.delegate = delegate
    }
    
    lazy var backButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "back"), for: .normal)
        button.addTarget(self, action: #selector(self.tappedBackButton), for: .touchUpInside)
        return button
    }()
    
    lazy var loginLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 35)
        label.text = "Meus Dados"
        label.textColor = UIColor(named: "mainPurpleColor")
        return label
    }()

    lazy var logoAppImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage( named: "signinImagepng" )
        image.contentMode = .scaleAspectFit
        return image
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
    
    lazy var registerButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("solicitar", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(named: "mainPurpleColor")
        button.clipsToBounds = true
        button.layer.cornerRadius = 9
        button.addTarget(self, action: #selector(tappedRegisterButton), for: .touchUpInside)
        return button
    }()
    
    @objc private func tappedBackButton() {
        delegate?.actionBackButton()
    }
    
    private func configBackground() {
        backgroundColor = .white
    }
    
    private func configSuperView() {
        addSubview(backButton)
        addSubview(cardTableView)
        addSubview(registerButton)
        cardTableView.addSubview(registerButton)
        cardTableView.addSubview(loginLabel)
        cardTableView.addSubview(logoAppImageView)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configBackground()
        configSuperView()
        configConstraints()
    }

    @objc private func tappedRegisterButton(){
        delegate?.actionRegisterButton()
    }

    private func configTableViewProtocols(delegate: UITableViewDelegate, dataSource : UITableViewDataSource) {
        cardTableView.delegate = delegate
        cardTableView.dataSource = dataSource
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configButtonEnable(_ enable : Bool) {
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
            
            cardTableView.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            cardTableView.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
            cardTableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            cardTableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            cardTableView.heightAnchor.constraint(equalToConstant: 400),
            
            loginLabel.centerXAnchor.constraint(equalTo: cardTableView.centerXAnchor),
            loginLabel.topAnchor.constraint(equalTo: cardTableView.topAnchor, constant: 20),
                
            logoAppImageView.centerXAnchor.constraint(equalTo: cardTableView.centerXAnchor),
            logoAppImageView.topAnchor.constraint(equalTo: loginLabel.bottomAnchor, constant: 20),
            logoAppImageView.heightAnchor.constraint(equalToConstant: 200),
            logoAppImageView.widthAnchor.constraint(equalToConstant: 200),
                
            registerButton.centerXAnchor.constraint(equalTo: cardTableView.centerXAnchor),
            registerButton.topAnchor.constraint(equalTo: logoAppImageView.bottomAnchor, constant: 40),
            registerButton.leadingAnchor.constraint(equalTo: cardTableView.leadingAnchor, constant: 35),
            registerButton.trailingAnchor.constraint(equalTo: cardTableView.trailingAnchor, constant: -35)

        ])
    }
}


