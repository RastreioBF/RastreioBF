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
        configBackground()
        addElement()
        configConstraints()
    }
    
    func configBackground(){
        backgroundColor = .white
    }
    
    func addElement(){
        addSubview(warningTitleLabel)
        addSubview(tableViewData)
        addSubview(tableViewEmpty)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configConstraints() {
        NSLayoutConstraint.activate([
            warningTitleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: -25),
            warningTitleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            tableViewData.topAnchor.constraint(equalTo: warningTitleLabel.bottomAnchor),
            tableViewData.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
            tableViewData.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor),
            tableViewData.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            
            tableViewEmpty.topAnchor.constraint(equalTo: warningTitleLabel.bottomAnchor),
            tableViewEmpty.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
            tableViewEmpty.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor),
            tableViewEmpty.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
