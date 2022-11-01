//
//  MenuRastreioScreen.swift
//  BackFrontProject
//
//  Created by ALYSSON MENEZES on 24/08/22.
//

import UIKit



class DescricaoScreen : UIView {
    
    lazy var loginLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 35)
        label.text = "Descrição"
       
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
        self.addSubview(self.loginLabel)
    
        
    }
    
    private  func setupConstraints() {
        NSLayoutConstraint.activate([
        
            self.loginLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20),
            self.loginLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
        ])
    }
    
}
