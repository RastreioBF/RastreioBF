//
//  MeusDadosScreen.swift
//  BackFrontProject
//
//  Created by ALYSSON MENEZES on 25/08/22.
//

import UIKit

protocol RemoveUserScreenProtocol: class{
    func actionBackButton()
    func actionRegisterButton()
}

class  RemoveUserView: UIView {
    
    weak private var delegate : RemoveUserScreenProtocol?
    
    func delegate( delegate: RemoveUserScreenProtocol?){
        self.delegate = delegate
    }
    
    lazy var backButton:UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "back"), for: .normal)
        button.addTarget(self, action: #selector(self.tappedBackButton), for: .touchUpInside)
        return button
    }()
    
    lazy var removeDadosLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(named: "mainPurpleColor")
        label.font = UIFont.boldSystemFont(ofSize: 40)
        label.text = "Remover Conta"
        
        return label
    }()
    
    lazy var logoAppImageView : UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage( named: "removeUser" )
        image.contentMode = .scaleAspectFit
        //image.backgroundColor = .red
        return image
    }()
    
    lazy var  tableView : UITableView = {
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
    
    private func configBackGround(){
        self.backgroundColor = .white
    }
    
    @objc private func tappedBackButton(){
        self.delegate?.actionBackButton()
    }
    
    private func configSuperView() {
        
        addSubview(self.backButton)
        addSubview(self.removeDadosLabel)
        addSubview(self.tableView)
        self.tableView.addSubview(self.removeDadosLabel)
        self.addSubview(self.logoAppImageView)
        self.addSubview(registerButton)
        
        self.tableView.addSubview(self.registerButton)
        
  
        
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
        self.tableView.delegate = delegate
        self.tableView.dataSource = dataSource
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
            
            self.tableView.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            self.tableView.centerYAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerYAnchor),
            
            self.tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            self.tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            self.tableView.heightAnchor.constraint(equalToConstant: 500),
            
            self.removeDadosLabel.centerXAnchor.constraint(equalTo: self.tableView.centerXAnchor),
            self.removeDadosLabel.topAnchor.constraint(equalTo: self.tableView.topAnchor, constant: 35),
            
            self.logoAppImageView.centerXAnchor.constraint(equalTo: self.tableView.centerXAnchor, constant: 20),
            self.logoAppImageView.centerYAnchor.constraint(equalTo: self.tableView.centerYAnchor ),
            self.logoAppImageView.heightAnchor.constraint(equalToConstant: 150),
            
            self.registerButton.centerXAnchor.constraint(equalTo: self.tableView.centerXAnchor),
            
            self.registerButton.topAnchor.constraint(equalTo: self.logoAppImageView.bottomAnchor, constant: 80),
            self.registerButton.leadingAnchor.constraint(equalTo: self.tableView.leadingAnchor, constant: 35),
            self.registerButton.trailingAnchor.constraint(equalTo: self.tableView.trailingAnchor, constant: -35),
            
        
        ])
    }
}


