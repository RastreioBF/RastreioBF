//
//  PendenciesView.swift
//  RastreioBF
//
//  Created by Anderson Sales on 03/12/22.
//

import UIKit

class PendenciesView: UIView {
    
    lazy var pendenciesTitleLabel : UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = LC.pendenciesTitle.text
        label.textColor = .darkGray
        label.font = UIFont.boldSystemFont(ofSize: 25)
        return label
    }()
    
    lazy var tableView : UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.register(ProductDetailTableViewCell.self, forCellReuseIdentifier: ProductDetailTableViewCell.identifier)
        return tableView
    }()

    func setupBackgroundColor(){
        backgroundColor = .white
    }
    
    override init(frame : CGRect) {
        super.init( frame : frame)
        self.setupBackgroundColor()
        self.addElement()
        self.setupConstraints()
    }
    
    func addElement(){
        self.addSubview(self.pendenciesTitleLabel)
        self.addSubview(self.tableView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
     func setupConstraints() {
        NSLayoutConstraint.activate([
        
            self.pendenciesTitleLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: -25),
            self.pendenciesTitleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            self.tableView.topAnchor.constraint(equalTo: self.pendenciesTitleLabel.bottomAnchor),
            self.tableView.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor),
            self.tableView.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}
