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
        image.image = UIImage( systemName: "truck")
        return image
    }()
    
    lazy var  productNameLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .darkGray
        label.numberOfLines = 1
        return label
    }()
    
    lazy var  codeTrakingLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.numberOfLines = 1
        return label
    }()
    
    lazy var  productDescriptionLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.numberOfLines = 2
        return label
    }()
    
    lazy var  productDateLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.numberOfLines = 1
        return label
    }()
    
    lazy var  productTimeLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.numberOfLines = 1
        return label
    }()
    
    lazy var productStatusImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleToFill
        image.clipsToBounds = false
        image.layer.cornerRadius = 15
        image.image = UIImage(named: "done")
        return image
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
         self.contentView.addSubview(self.productDateLabel)
         self.contentView.addSubview(self.productTimeLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setupCell(data: DataProduct){
        self.productNameLabel.text = data.productDescription
        self.codeTrakingLabel.text = data.codeTraking
//        self.productImageView.image = UIImage(named: data.productNameImage)
        self.productDescriptionLabel.text = data.status
        self.productDateLabel.text = data.productLocal
        self.productTimeLabel.text = data.time
    }
    
    func setupConstraints(){
        NSLayoutConstraint.activate([
            
            self.productImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.productImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            self.productImageView.heightAnchor.constraint(equalToConstant: 80),
            self.productImageView.widthAnchor.constraint(equalToConstant: 80),
            
            self.productNameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            self.productNameLabel.leadingAnchor.constraint(equalTo: self.productImageView.trailingAnchor, constant: 10),
            self.productNameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 10),
            
            self.codeTrakingLabel.topAnchor.constraint(equalTo: self.productNameLabel.bottomAnchor ),
            self.codeTrakingLabel.leadingAnchor.constraint(equalTo: self.productImageView.trailingAnchor, constant: 10),
            
            self.productDescriptionLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor , constant: 20),
            self.productDescriptionLabel.leadingAnchor.constraint(equalTo: self.productImageView.trailingAnchor, constant: 10),
            self.productDescriptionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            
            self.productDateLabel.topAnchor.constraint(equalTo: self.productImageView.bottomAnchor),
            self.productDateLabel.leadingAnchor.constraint(equalTo: self.productImageView.leadingAnchor),
            
            self.productTimeLabel.topAnchor.constraint(equalTo: self.productDescriptionLabel.bottomAnchor ),
            self.productTimeLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
        ])
    }
    
}

