//
//  ProductDetailTableViewCell.swift
//  RastreioBF
//
//  Created by Jessica Bigal on 17/09/22.
//

import UIKit
import Foundation

class ProductDetailTableViewCell: UITableViewCell {
    
    static let identifier : String = "ProductDetailTableViewCell"
    
    lazy var  productImageView : UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleToFill
        image.clipsToBounds = false
        image.layer.cornerRadius = 15
        image.image = UIImage(named: "truck")
        return image
    }()
    
    lazy var  productNameLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 15)
        label.numberOfLines = 1
        return label
    }()
    
    lazy var  codeTrakingLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = .systemFont(ofSize: 12)
        label.numberOfLines = 0
        return label
    }()
    
    lazy var  productDescriptionLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = .systemFont(ofSize: 16)
        label.numberOfLines = 0 
        return label
    }()
    
    lazy var  lineLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .darkGray
        return label
    }()
    
    lazy var  productDateLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    
    
    lazy var  productTimeDateLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 10)
        return label
    }()
    
    lazy var  productLocalLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    
    private func configBackground(){
        self.backgroundColor = .red
    }
    
    override func setSelected(_ selected : Bool, animated : Bool){
        super.setSelected(selected, animated: animated)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addSubview()
        self.setupConstraints()
        self.selectionStyle = .none
    }
    
     func addSubview() {
         self.contentView.addSubview(self.productImageView)
         self.contentView.addSubview(self.productNameLabel)
         self.contentView.addSubview(self.codeTrakingLabel)
         self.contentView.addSubview(self.productDescriptionLabel)
         self.contentView.addSubview(self.productTimeDateLabel)
         self.contentView.addSubview(self.productLocalLabel)
         self.contentView.addSubview(self.lineLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setupCell(data: DataProduct){
        self.productNameLabel.text = data.productDescription
        self.codeTrakingLabel.text = data.codeTraking
        self.productDescriptionLabel.text = data.status
        self.productLocalLabel.text = data.productLocal
        self.productTimeDateLabel.text = "\(data.date ?? "") - \(data.time ?? "")"
    }
    
    func setupConstraints(){
        NSLayoutConstraint.activate([
            
            self.productImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            self.productImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 2),
            self.productImageView.heightAnchor.constraint(equalToConstant: 80),
            self.productImageView.widthAnchor.constraint(equalToConstant: 80),
            
            self.productLocalLabel.topAnchor.constraint(equalTo: self.productImageView.bottomAnchor, constant: 5 ),
            self.productLocalLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 2),
            
            self.lineLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.lineLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.lineLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.lineLabel.heightAnchor.constraint(equalToConstant: 0.5),
            
            self.productNameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            self.productNameLabel.leadingAnchor.constraint(equalTo: self.productImageView.trailingAnchor, constant: 15),
            self.productNameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            
            self.codeTrakingLabel.topAnchor.constraint(equalTo: self.productNameLabel.bottomAnchor,constant: 2 ),
            self.codeTrakingLabel.leadingAnchor.constraint(equalTo: self.productImageView.trailingAnchor, constant: 15),
            self.codeTrakingLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            
            self.productDescriptionLabel.topAnchor.constraint(equalTo: self.codeTrakingLabel.bottomAnchor,constant: 2 ),
            self.productDescriptionLabel.leadingAnchor.constraint(equalTo: self.productImageView.trailingAnchor, constant: 15),
            self.productDescriptionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            self.productDescriptionLabel.bottomAnchor.constraint(equalTo: self.productTimeDateLabel.topAnchor),
            
            self.productTimeDateLabel.centerYAnchor.constraint(equalTo: self.productLocalLabel.centerYAnchor),
            self.productTimeDateLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10)
            
        ])
    }
    
}

