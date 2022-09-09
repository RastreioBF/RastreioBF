//
//  MeusDadosScreen.swift
//  BackFrontProject
//
//  Created by ALYSSON MENEZES on 25/08/22.
//

import UIKit

protocol RemoveUserScreenProtocol: class{
 
    func actionRegisterButton()
}

class  RemoveUserScreen: UIView {
    
    weak private var delegate : RemoveUserScreenProtocol?
    
    func delegate( delegate: RemoveUserScreenProtocol?){
        self.delegate = delegate
    }
    

    lazy var removeDadosLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .systemRed
        label.font = UIFont.boldSystemFont(ofSize: 35)
        label.text = "Remover Conta"

        return label
    }()
    
    lazy var logoAppImageView : UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage( named: "removeUserIcon" )
        image.contentMode = .scaleAspectFit
        //image.backgroundColor = .red
        return image
    }()
    
    lazy var  tableView : UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .white
        // border
        tableView.layer.borderWidth = 4.0
        tableView.layer.borderColor = UIColor.gray.cgColor
        // shadow
        tableView.layer.shadowColor = UIColor.black.cgColor
        tableView.layer.shadowOffset = CGSize(width: 3, height: 3)
        tableView.layer.shadowOpacity = 1.0
        tableView.layer.shadowRadius = 10.0
        //tableView.register(MeusDadosTableViewCell.self , forCellReuseIdentifier: MeusDadosTableViewCell.identifier)
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
        button.backgroundColor = .systemRed //UIColor( red: 102/255, green: 103/255, blue: 171/255, alpha: 1.0)
        button.addTarget(self, action: #selector(tappedRegisterButton), for: .touchUpInside)
        
        return button
    }()
    
    lazy var emailAlertTextField : UITextField = {
        let email = UITextField()
        email.translatesAutoresizingMaskIntoConstraints = false
        email.autocorrectionType = .no
        email.backgroundColor = .white
        email.borderStyle = .roundedRect
        email.keyboardType = .emailAddress
        email.placeholder = "digite seu e-mail:"
        email.font = UIFont.systemFont( ofSize: 14)
        email.textColor = .darkGray
        
        return email
    }()
    
    private func configBackGround(){
        self.backgroundColor = .white
    }
    
    private func configSuperView() {
       addSubview(self.removeDadosLabel)
        addSubview(self.tableView)
        self.tableView.addSubview(self.removeDadosLabel)
        self.addSubview(self.logoAppImageView)
        self.addSubview(registerButton)
        
        self.tableView.addSubview(self.registerButton)
        
        addSubview(self.emailAlertTextField)
                
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
            
            self.tableView.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            self.tableView.centerYAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerYAnchor),
            
            self.tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            self.tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            self.tableView.heightAnchor.constraint(equalToConstant: 500),
            
//
            self.removeDadosLabel.centerXAnchor.constraint(equalTo: self.tableView.centerXAnchor),
            self.removeDadosLabel.topAnchor.constraint(equalTo: self.tableView.topAnchor, constant: 20),
//
           // self.logoAppImageView.centerXAnchor.constraint(equalTo: self.tableView.centerXAnchor ),
            self.logoAppImageView.topAnchor.constraint(equalTo: self.removeDadosLabel.bottomAnchor, constant: 10),
            self.logoAppImageView.centerYAnchor.constraint(equalTo: self.tableView.centerYAnchor , constant: -100),
            self.logoAppImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            self.logoAppImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            self.logoAppImageView.heightAnchor.constraint(equalToConstant: 150),
        
            self.registerButton.centerXAnchor.constraint(equalTo: self.tableView.centerXAnchor),
         //   self.registerButton.centerYAnchor.constraint(equalTo: self.tableView.centerYAnchor),
            self.registerButton.topAnchor.constraint(equalTo: self.logoAppImageView.bottomAnchor, constant: 100),
            self.registerButton.leadingAnchor.constraint(equalTo: self.tableView.leadingAnchor, constant: 35),
            self.registerButton.trailingAnchor.constraint(equalTo: self.tableView.trailingAnchor, constant: -35),
            
            
            
            
        ])
    }
}


