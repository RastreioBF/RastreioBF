//
//  PrivacyPolicyScreen.swift
//  BackFrontProject
//
//  Created by ALYSSON MENEZES on 29/08/22.
//

import Foundation
import UIKit

class PrivacyView : UIView{
    
    lazy var loginLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .systemBlue
        label.font = UIFont.boldSystemFont(ofSize: 35)
        label.text = "Privacidade"
       
        return label
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
    
    lazy var privacidadeLabel : UILabel  = {
        let  label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        //label.font = UIFont.boldSystemFont(ofSize: 18)
        label.backgroundColor = .white
        label.numberOfLines = 22
        label.textAlignment = NSTextAlignment.justified
        
      
        
        label.text = "A política de privacidade (ou declaração de política de privacidade) é o documento por meio do qual a pessoa física ou jurídica que mantém um site ou aplicativo expõe e explica a todos os interessados a forma como os dados pessoais dos usuários da plataforma serão tratados. O assunto é regulamentado, no Brasil, principalmente pela Lei Geral de Proteção de Dados Pessoais (LGPD), lei que estabeleceu uma série de exigências àqueles que realizam operações de tratamento de dados pessoais. A lei se aplica: se a operação de tratamento é realizada no território nacional; se a atividade de tratamento tem por objetivo a oferta de produtos ou serviços ou o tratamento de dados de indivíduos localizados no território nacional; se os dados pessoais são coletados no território nacional."
        
        return label
    }()
    
    private func configBackGround(){
       // self.backgroundColor = UIColor(red: 24/255, green: 117/255, blue: 104/255, alpha: 1.0)
        self.backgroundColor = .white
    }
    
override init(frame: CGRect) {
        super.init( frame: frame)
        self.configBackGround()
        self.configSuperView()
        self.setupConstraints()
    
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configSuperView(){
      
      
        self.addSubview(self.cardTableView)
        self.addSubview(self.privacidadeLabel)
        self.addSubview(self.loginLabel)
        
        self.cardTableView.addSubview(loginLabel)
        self.cardTableView.addSubview(privacidadeLabel)
        
    }
    
    private  func setupConstraints() {
        NSLayoutConstraint.activate([
        
            self.loginLabel.topAnchor.constraint(equalTo: self.cardTableView.topAnchor, constant: 20),
            self.loginLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            self.cardTableView.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            self.cardTableView.centerYAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerYAnchor),
            
            self.cardTableView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            self.cardTableView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            self.cardTableView.heightAnchor.constraint(equalToConstant: 600),
            
            self.privacidadeLabel.topAnchor.constraint(equalTo: self.loginLabel.bottomAnchor, constant: 20),
            self.privacidadeLabel.centerXAnchor.constraint(equalTo: self.privacidadeLabel.centerXAnchor),
            self.privacidadeLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 35),
            self.privacidadeLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -35),
        ])
    }
}
