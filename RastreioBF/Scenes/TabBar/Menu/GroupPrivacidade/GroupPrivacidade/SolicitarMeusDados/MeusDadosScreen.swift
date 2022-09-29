
//
//  MeusDadosScreen.swift
//  BackFrontProject
//
//  Created by ALYSSON MENEZES on 25/08/22.
//

import UIKit

protocol MeusDadosScreenProtocol: class{
    func actionBackButton()
    func actionRegisterButton()
}

class  MeusDadosScreen: UIView {
    
    weak private var delegate : MeusDadosScreenProtocol?
    
    func delegate( delegate: MeusDadosScreenProtocol?){
        self.delegate = delegate
    }
    
    lazy var backButton:UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "back"), for: .normal)
        button.addTarget(self, action: #selector(self.tappedBackButton), for: .touchUpInside)
        return button
    }()
    
    lazy var loginLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.font = UIFont.boldSystemFont(ofSize: 35)
        label.text = "Meus Dados"
        label.textColor = UIColor(named: "mainPurpleColor")
        return label
    }()
    
    
    lazy var logoAppImageView : UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage( named: "signinImagepng" )
        image.contentMode = .scaleAspectFit
        //image.backgroundColor = .red
        return image
    }()
    
    
    lazy var  cardTableView : UITableView = {
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
    
    @objc private func tappedBackButton(){
        self.delegate?.actionBackButton()
    }
    
    private func configBackGround(){
        self.backgroundColor = .white
    }
    
    private func configSuperView() {
        addSubview(self.backButton)
        addSubview(self.cardTableView)
        self.cardTableView.addSubview(self.loginLabel)
        self.cardTableView.addSubview(self.logoAppImageView)
        self.addSubview(registerButton)
        
        self.cardTableView.addSubview(self.registerButton)
        
        
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configBackGround()
        self.configSuperView()
        self.setupConstraints()
        
    }
    
    
    
    
    @objc private func tappedRegisterButton(){
        self.delegate?.actionRegisterButton()
    }
    
    
    public func configTableViewProtocols(delegate: UITableViewDelegate, dataSource : UITableViewDataSource){
        self.cardTableView.delegate = delegate
        self.cardTableView.dataSource = dataSource
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configButtonEnable(_ enable : Bool ){
        if enable{
            self.registerButton.setTitleColor(.white, for: .normal)
            self.registerButton.isEnabled = true
        }else {
            self.registerButton.setTitleColor(.lightGray, for: .normal)
            self.registerButton.isEnabled = false
        }
    }
    
    private  func setupConstraints() {
        NSLayoutConstraint.activate([
            
            self.backButton.leadingAnchor.constraint(equalTo: self.backButton.leadingAnchor, constant: 35),
            self.backButton.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor,constant: 20),
            
            self.cardTableView.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            self.cardTableView.centerYAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerYAnchor),
            self.cardTableView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            self.cardTableView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            self.cardTableView.heightAnchor.constraint(equalToConstant: 400),
            
            
            self.loginLabel.centerXAnchor.constraint(equalTo: self.cardTableView.centerXAnchor),
            self.loginLabel.topAnchor.constraint(equalTo: self.cardTableView.topAnchor, constant: 20),
            
            self.logoAppImageView.centerXAnchor.constraint(equalTo: self.cardTableView.centerXAnchor),
            self.logoAppImageView.topAnchor.constraint(equalTo: self.loginLabel.bottomAnchor, constant: 20),
            self.logoAppImageView.heightAnchor.constraint(equalToConstant: 200),
            self.logoAppImageView.widthAnchor.constraint(equalToConstant: 200),
            
            self.registerButton.centerXAnchor.constraint(equalTo: self.cardTableView.centerXAnchor),
            self.registerButton.topAnchor.constraint(equalTo: self.logoAppImageView.bottomAnchor, constant: 40),
            
            self.registerButton.leadingAnchor.constraint(equalTo: self.cardTableView.leadingAnchor, constant: 35),
            self.registerButton.trailingAnchor.constraint(equalTo: self.cardTableView.trailingAnchor, constant: -35),
            
            
            
            
        ])
    }
}


