//
//  ProductDetailTableViewCell.swift
//  RastreioBF
//
//  Created by Jessica Bigal on 17/09/22.
//

import UIKit
import Foundation

class ProductDetailTableViewCell: UITableViewCell {
    
    static let identifier : String = String(describing: ProductDetailTableViewCell.self)
    
    lazy var productImageView : UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = false
        image.layer.cornerRadius = 15
        return image
    }()
    
    lazy var productNameLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 15)
        label.numberOfLines = 1
        return label
    }()
    
    lazy var codeTrakingLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = .systemFont(ofSize: 12)
        label.numberOfLines = 0
        return label
    }()
    
    lazy var productDescriptionLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = .systemFont(ofSize: 16)
        label.numberOfLines = 0
        return label
    }()
    
    lazy var productDateLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    
    lazy var productTimeDateLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 10)
        return label
    }()
    
    lazy var productLocalLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    
    override func setSelected(_ selected : Bool, animated : Bool){
        super.setSelected(selected, animated: animated)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview()
        configureConstraints()
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubview() {
        addSubview(productImageView)
        addSubview(productNameLabel)
        addSubview(codeTrakingLabel)
        addSubview(productDescriptionLabel)
        addSubview(productTimeDateLabel)
        addSubview(productLocalLabel)
    }
    
    public func setupCell(data: DataProduct){
        productNameLabel.text = data.productDescription
        codeTrakingLabel.text = data.codeTraking
        productDescriptionLabel.text = data.status
        productLocalLabel.text = data.productLocal
        productImageView.image = UIImage(systemName: data.image ?? "")
        productImageView.tintColor = UIColor(named: data.tintColor ?? "")
        productTimeDateLabel.text = "\(data.date ?? "") - \(data.time ?? "")"
    }
    
    private func configureConstraints(){
        NSLayoutConstraint.activate([
            productImageView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            productImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            productImageView.heightAnchor.constraint(equalToConstant: 70),
            productImageView.widthAnchor.constraint(equalToConstant: 70),
            
            productLocalLabel.topAnchor.constraint(equalTo: productImageView.bottomAnchor, constant: 10 ),
            productLocalLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            
            productNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            productNameLabel.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 15),
            productNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            
            codeTrakingLabel.topAnchor.constraint(equalTo: productNameLabel.bottomAnchor,constant: 2 ),
            codeTrakingLabel.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 15),
            codeTrakingLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            
            productDescriptionLabel.topAnchor.constraint(equalTo: codeTrakingLabel.bottomAnchor,constant: 2 ),
            productDescriptionLabel.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 15),
            productDescriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            productDescriptionLabel.bottomAnchor.constraint(equalTo: productTimeDateLabel.topAnchor),
            
            productTimeDateLabel.centerYAnchor.constraint(equalTo: productLocalLabel.centerYAnchor),
            productTimeDateLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
            
        ])
    }
}
