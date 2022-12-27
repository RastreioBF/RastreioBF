//
//  DetailWarningView.swift
//  RastreioBF
//
//  Created by Anderson Sales on 04/12/22.
//

import UIKit

class DetailWarningView: UIView {
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.register(PackageCell.self, forCellReuseIdentifier: PackageCell.identifier)
        return tableView
    }()
    
    private func configBackground() {
        backgroundColor = .white
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configBackground()
        addElement()
        configConstraints()
    }
    
    private func addElement(){
        addSubview(tableView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            tableView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
