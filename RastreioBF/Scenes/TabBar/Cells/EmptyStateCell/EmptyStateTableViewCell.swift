//
//  EmptyStateTableViewCell.swift
//  RastreioBF
//
//  Created by Jessica Bigal on 23/12/22.
//

import UIKit

class EmptyStateTableViewCell: UITableViewCell {
    
    static let identifier = "EmptyStateTableViewCell"
    
    lazy var  statusLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 15)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.text = LC.nothingHere.text
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addSubview()
        self.setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func addSubview() {
        self.contentView.addSubview(statusLabel)
    }
    
    func setupConstraints(){
        NSLayoutConstraint.activate([
            self.statusLabel.topAnchor.constraint(equalTo: self.topAnchor),
            self.statusLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.statusLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.statusLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
}

