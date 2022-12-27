//
//  EmptyStateTableViewCell.swift
//  RastreioBF
//
//  Created by Jessica Bigal on 23/12/22.
//

import UIKit

class EmptyStateTableViewCell: UITableViewCell {
    
    static let identifier = String(describing: EmptyStateTableViewCell.self)
    
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
        addSubview()
        configConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func addSubview() {
        contentView.addSubview(statusLabel)
    }
    
    func configConstraints(){
        NSLayoutConstraint.activate([
            statusLabel.topAnchor.constraint(equalTo: topAnchor),
            statusLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            statusLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            statusLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
