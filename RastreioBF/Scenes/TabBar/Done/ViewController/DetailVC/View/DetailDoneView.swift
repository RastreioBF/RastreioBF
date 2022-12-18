//
//  DetailDoneView.swift
//  RastreioBF
//
//  Created by Anderson Sales on 04/12/22.
//

import UIKit

class DetailDoneView: UIView {
    
    lazy var detailTitleLabel : UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Avisos RastreioBF"
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
    
    public func configTableViewProtocols( delegate: UITableViewDelegate, dataSource: UITableViewDataSource){
        self.tableView.delegate = delegate
        self.tableView.dataSource = dataSource
    }
    
    func addElement(){
        self.addSubview(self.detailTitleLabel)
        self.addSubview(self.tableView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
     func setupConstraints() {
        NSLayoutConstraint.activate([
        
            self.detailTitleLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: -25),
            self.detailTitleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            self.tableView.topAnchor.constraint(equalTo: self.detailTitleLabel.bottomAnchor),
            self.tableView.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor),
            self.tableView.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    public func setupCell(data: DataProduct){
        self.detailTitleLabel.text = data.productDescription
    }
}
