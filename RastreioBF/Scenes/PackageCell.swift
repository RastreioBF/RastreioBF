//
//  PackageCell.swift
//  RastreioBF
//
//  Created by Jessica Bigal on 13/12/22.
//

import UIKit

class PackageCell: UITableViewCell {
    
    static let identifier = String(describing: PackageCell.self)
    
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
    
    lazy var cityNameLabel: UILabel = {
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
    
    private func configUIElements() {
        contentView.addSubview(iconImageView)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(cityNameLabel)
        contentView.addSubview(dataLabel)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configUIElements()
        configConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func prepareCell(model: Events) {
        descriptionLabel.text = model.status
        dataLabel.text = "Data:\(model.data ?? "")"
        cityNameLabel.text = "Local:\(model.local ?? "")"
        var image = ""
        let status = model.status ?? ""
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
        
        iconImageView.image = UIImage(systemName: image)
        iconImageView.tintColor = UIColor(named: tintColor)
    }
    
    private func configConstraints() {
        
        NSLayoutConstraint.activate([
            
            iconImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            iconImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            iconImageView.heightAnchor.constraint(equalToConstant: 50),
            iconImageView.widthAnchor.constraint(equalToConstant: 50),
            
            descriptionLabel.topAnchor.constraint(equalTo: iconImageView.topAnchor, constant: -5),
            descriptionLabel.leftAnchor.constraint(equalTo: iconImageView.rightAnchor, constant: 10),
            descriptionLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -5),
            descriptionLabel.widthAnchor.constraint(equalToConstant: 250),
            
            cityNameLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor),
            cityNameLabel.leftAnchor.constraint(equalTo: descriptionLabel.leftAnchor),
            cityNameLabel.rightAnchor.constraint(equalTo: descriptionLabel.rightAnchor),
            cityNameLabel.widthAnchor.constraint(equalToConstant: 100),
            
            dataLabel.topAnchor.constraint(equalTo: cityNameLabel.bottomAnchor),
            dataLabel.leftAnchor.constraint(equalTo: cityNameLabel.leftAnchor),
            dataLabel.widthAnchor.constraint(equalToConstant: 120)
            
        ])
    }
}
