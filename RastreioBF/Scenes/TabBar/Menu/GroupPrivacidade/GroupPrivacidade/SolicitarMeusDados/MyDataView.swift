//
//  MeusDadosScreen.swift
//  BackFrontProject
//
//  Created by ALYSSON MENEZES on 25/08/22.
//

import UIKit

protocol MyDataViewProtocol: AnyObject{
 
    func actionRegisterButton()
}

class  MyDataView: UIView {
    
    weak private var delegate : MyDataViewProtocol?
    
    func delegate( delegate: MyDataViewProtocol?){
        self.delegate = delegate
    }
    

    lazy var loginLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .systemBlue
        label.font = UIFont.boldSystemFont(ofSize: 35)
        label.text = "Meus Dados"

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
        
        // border
        tableView.layer.borderWidth = 2.0
        tableView.layer.borderColor = UIColor.gray.cgColor

        // shadow
        tableView.layer.shadowColor = UIColor.gray.cgColor
        tableView.layer.shadowOffset = CGSize(width: 3, height: 3)
        tableView.layer.shadowOpacity = 0.7
        tableView.layer.shadowRadius = 10
        
        tableView.isScrollEnabled = false
        tableView.layer.cornerRadius = 15
       // tableView.layer.borderColor = UIColor.darkGray.cgColor
        //tableView.register(MeusDadosTableViewCell.self , forCellReuseIdentifier: MeusDadosTableViewCell.identifier)
        return tableView
    }()
    
    lazy var registerButton: UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("solicitar", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.clipsToBounds = true
        button.layer.cornerRadius = 9
        button.backgroundColor = .systemBlue //UIColor( red: 102/255, green: 103/255, blue: 171/255, alpha: 1.0)
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
      
        addSubview(self.cardTableView)
       
        self.cardTableView.addSubview(self.loginLabel)
        self.cardTableView.addSubview(self.logoAppImageView)
        self.addSubview(registerButton)
        
        self.cardTableView.addSubview(self.registerButton)
        
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
        self.cardTableView.delegate = delegate
        self.cardTableView.dataSource = dataSource
    }
    
    

    
    public func getEmail()-> String{
        return self.emailAlertTextField.text ?? ""
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


