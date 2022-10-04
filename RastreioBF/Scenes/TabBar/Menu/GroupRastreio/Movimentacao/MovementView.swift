//
//  MovimentacaoScreen.swift
//  BackFrontProject
//
//  Created by ALYSSON MENEZES on 25/08/22.
//

import UIKit

class MovementView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configBackGround()
        self.configSuperView()
        self.setupConstraints()
    }
    
  
    
    lazy var loginLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 40)
        label.text = "Movimentação"
        return label
    }()
    
    private func configBackGround(){
        self.backgroundColor = UIColor(red: 244/255, green: 34/255, blue: 24/255, alpha: 1.0)
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
