//
//  PackageCell.swift
//  RastreioBF
//
//  Created by Jessica Bigal on 13/12/22.
//

import UIKit

class PackageCell: UITableViewCell {
    
    static let identifier = "PackageCell"
    
    lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 7
        return imageView
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.numberOfLines = 2
        label.textColor = .black
        return label
    }()
    
    lazy var cidadeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor =  .black
        label.font = UIFont.systemFont(ofSize: 11)
        return label
    }()
    
    lazy var dataLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor =  .black
        label.font = UIFont.systemFont(ofSize: 10)
        return label
    }()
    
    
    private func setUpUIElements() {
        self.contentView.addSubview(self.iconImageView)
        self.contentView.addSubview(self.descriptionLabel)
        self.contentView.addSubview(self.cidadeLabel)
        self.contentView.addSubview(self.dataLabel)
    }
    
    private func setUpUIConstraints() {
        self.configIconImageViewConstraints()
        self.configTestLabel()
        self.configCidadeLabelConstraints()
        self.configDataLabelConstraints()
        
    }
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUpUIElements()
        self.setUpUIConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func configIconImageViewConstraints() {
        NSLayoutConstraint.activate([
            
            self.iconImageView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10),
            self.iconImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
            self.iconImageView.heightAnchor.constraint(equalToConstant: 50),
            self.iconImageView.widthAnchor.constraint(equalToConstant: 50),
            
        ])
    }
    
    private func configTestLabel() {
        NSLayoutConstraint.activate([
            self.descriptionLabel.topAnchor.constraint(equalTo: self.iconImageView.topAnchor, constant: -5),
            self.descriptionLabel.leftAnchor.constraint(equalTo: self.iconImageView.rightAnchor, constant: 10),
            self.descriptionLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -5),
            self.descriptionLabel.widthAnchor.constraint(equalToConstant: 250),
            
        ])
    }
    
    private func configCidadeLabelConstraints() {
        NSLayoutConstraint.activate([
            self.cidadeLabel.topAnchor.constraint(equalTo: self.descriptionLabel.bottomAnchor),
            self.cidadeLabel.leftAnchor.constraint(equalTo: self.descriptionLabel.leftAnchor),
            self.cidadeLabel.rightAnchor.constraint(equalTo: self.descriptionLabel.rightAnchor),
            self.cidadeLabel.widthAnchor.constraint(equalToConstant: 100),
            
        ])
    }
    
    private func configDataLabelConstraints() {
        NSLayoutConstraint.activate([
            self.dataLabel.topAnchor.constraint(equalTo: self.cidadeLabel.bottomAnchor),
            self.dataLabel.leftAnchor.constraint(equalTo: self.cidadeLabel.leftAnchor),
            self.dataLabel.widthAnchor.constraint(equalToConstant: 120)
        ])
    }

    func prepareCell(model: Eventos) {
        self.descriptionLabel.text = model.status
        self.dataLabel.text = "Data:\(model.data ?? "")"
        self.cidadeLabel.text = "Local:\(model.local ?? "")"
        var image = ""
        var status = model.status ?? ""
        var tintColor = ""
        
        if status.contains(LC.payment.text) ||
            status.contains(LC.analysis.text) ||
            status.contains(LC.customs.text) ||
            status.contains(LC.missing.text){
            image = LC.errorImage.text
            tintColor = LC.redColor.text
        } else if status.contains(LC.delivered.text) ||
                    status.contains(LC.toBeDelivered.text) ||
                    status.contains(LC.deliveredCaps.text){
            image = LC.doneImage.text
            tintColor = LC.greenColor.text
        } else {
            image = LC.onItsWayImage.text
            tintColor = LC.orangeColor.text
        }
        
        self.iconImageView.image = UIImage(systemName: image)
        self.iconImageView.tintColor = UIColor(named: tintColor)
    }
}

