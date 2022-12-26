//
//  WarningView.swift
//  RastreioBF
//
//  Created by Anderson Sales on 03/12/22.
//

import UIKit

class WarningView: UIView {
    
    private var viewModel = WarningViewModel()
    
    lazy var warningTitleLabel : UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = LC.warningTitle.text
        label.textColor = .darkGray
        label.font = UIFont.boldSystemFont(ofSize: 25)
        return label
    }()
    
    lazy var tableViewData : UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.register(ProductDetailTableViewCell.self, forCellReuseIdentifier: ProductDetailTableViewCell.identifier)
        return tableView
    }()
    
    lazy var tableViewEmpty : UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.register(EmptyStateTableViewCell.self, forCellReuseIdentifier: EmptyStateTableViewCell.identifier)
        return tableView
    }()
    
    override init(frame : CGRect) {
        super.init( frame : frame)
        self.setupBackgroundColor()
        self.addElement()
        self.setupConstraints()
    }
    
    func setupBackgroundColor(){
        backgroundColor = .white
    }
    
    func addElement(){
        self.addSubview(self.warningTitleLabel)
        self.addSubview(self.tableViewData)
        self.addSubview(self.tableViewEmpty)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
     func setupConstraints() {
        NSLayoutConstraint.activate([
            self.warningTitleLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: -25),
            self.warningTitleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            self.tableViewData.topAnchor.constraint(equalTo: self.warningTitleLabel.bottomAnchor),
            self.tableViewData.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor),
            self.tableViewData.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor),
            self.tableViewData.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            
            self.tableViewEmpty.topAnchor.constraint(equalTo: self.warningTitleLabel.bottomAnchor),
            self.tableViewEmpty.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor),
            self.tableViewEmpty.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor),
            self.tableViewEmpty.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
