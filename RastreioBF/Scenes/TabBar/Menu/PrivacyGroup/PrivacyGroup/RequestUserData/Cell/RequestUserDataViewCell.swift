//
//  MeusDadosTableViewCell.swift
//  BackFrontProject
//
//  Created by ALYSSON MENEZES on 30/08/22.
//

import UIKit

class RequestUserDataViewCell: UITableViewCell {

    static let identifier: String = String(describing: RequestUserDataViewCell.self)
    
    lazy var userImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.backgroundColor = .white
        return image
    }()
    
    lazy var emailTextField: UITextField = {
        let email = UITextField()
        email.translatesAutoresizingMaskIntoConstraints = false
        email.autocorrectionType = .no
        email.backgroundColor = .white
        email.borderStyle = .roundedRect
        email.keyboardType = .emailAddress
        email.placeholder = "digite seu e-mail:"
        email.font = UIFont.systemFont(ofSize: 14)
        email.textColor = .darkGray
        return email
    }()
    
    lazy var passwordTextField: UITextField = {
        let password = UITextField()
        password.translatesAutoresizingMaskIntoConstraints = false
        password.autocorrectionType = .no
        password.backgroundColor = .white
        password.borderStyle = .roundedRect
        password.placeholder = "digite sua senha:"
        password.font = UIFont.systemFont( ofSize: 14)
        password.textColor = .darkGray
        return password
    }()
    
    lazy var registerButton: UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("salvar ", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.clipsToBounds = true
        button.layer.cornerRadius = 7.5
        button.backgroundColor = UIColor( red: 102/255, green: 103/255, blue: 171/255, alpha: 1.0)
        return button
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview()
        configConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func addSubview() {
       addSubview(userImageView)
       addSubview(emailTextField)
       addSubview(passwordTextField)
       addSubview(registerButton)
   }
    
    private func configConstraints() {
        
        NSLayoutConstraint.activate([
            
            userImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            userImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            userImageView.heightAnchor.constraint(equalToConstant: 80),
            userImageView.widthAnchor.constraint(equalToConstant: 80),
            
            emailTextField.centerYAnchor.constraint(equalTo: centerYAnchor),
            emailTextField.leadingAnchor.constraint(equalTo: userImageView.trailingAnchor, constant: 20)
            
        ])
    }
}
