//
//  MeusDadosTableViewCell.swift
//  BackFrontProject
//
//  Created by ALYSSON MENEZES on 30/08/22.
//

import UIKit

class MeusDadosTableViewCell: UITableViewCell {

    static let identifier:String = "MeusDadosTableViewCell"
    
    lazy var userImageView : UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
            //image.image = UIImage( named: "addUserIcon")
        image.contentMode = .scaleAspectFit
        image.backgroundColor = .white
        
        
        return image
    }()
    
    lazy var emailTextField : UITextField = {
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
    
    
    lazy var passwordTextField : UITextField = {
        let password = UITextField()
        password.translatesAutoresizingMaskIntoConstraints = false
        password.autocorrectionType = .no
        password.backgroundColor = .white
        password.borderStyle = .roundedRect
        //password.keyboardType = .default
        //password.isSecureTextEntry = true
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
     //   button.addTarget(self, action: #selector(tappedRegisterButton), for: .touchUpInside)
        
        return button
    }()

 
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addSubview()
        self.setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func addSubview() {
       self.addSubview(self.userImageView)
       self.addSubview(self.emailTextField)
       self.addSubview(self.passwordTextField)
       self.addSubview(self.registerButton)
   }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            self.userImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.userImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.userImageView.heightAnchor.constraint(equalToConstant: 80),
            self.userImageView.widthAnchor.constraint(equalToConstant: 80),
            
            self.emailTextField.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.emailTextField.leadingAnchor.constraint(equalTo: self.self.userImageView.trailingAnchor, constant: 20),
            
        ])
    }

}
