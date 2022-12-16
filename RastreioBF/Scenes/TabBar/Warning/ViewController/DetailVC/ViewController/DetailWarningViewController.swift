//
//  DetailWarningViewController.swift
//  RastreioBF
//
//  Created by Anderson Sales on 04/12/22.
//

import UIKit

class DetailWarningViewController: UIViewController {
    
    private var detailWarningView: DetailWarningView?
    private var viewModel = DetailWarningViewControllerViewModel()
    var data: DataProduct?
    var dataTracking: DataTracking?
    
    var codigo: String
    var descriptionClient: String
    
    init(codigo: String, descriptionClient: String) {
        self.codigo = codigo
        self.descriptionClient = descriptionClient
        super.init(nibName: nil, bundle: nil)
        hidesBottomBarWhenPushed = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        detailWarningView = DetailWarningView()
        view = detailWarningView
    }
    
    override func viewDidLoad() {
        self.detailWarningView?.configTableViewProtocols(delegate: self, dataSource: self)
        self.detailWarningView?.tableView.separatorStyle = .none
        self.title = codigo.text
    }
    
    override func viewWillAppear(_ animated: Bool) {
         viewModel.fetchPackage()
//        viewModel.fetchPackageAlamofire(code: codigo.text)
//        viewModel.fetchPackageURLSession(code: codigo.text)
//        viewModel.fetchPackageURLSessionNoLink()
    }
    
}

extension  DetailWarningViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.numberaOfRowsInSection
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: PackageCell? = tableView.dequeueReusableCell(withIdentifier: PackageCell.identifier, for: indexPath) as? PackageCell
        cell?.prepareCell(model: self.viewModel.loadCurrentDetailAccountList(indexPath: indexPath))
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.viewModel.heightForRowAt
    }
}

extension DetailWarningViewController: DetailWarningViewModelProtocols {
    func success() {
        self.detailWarningView?.tableView.reloadData()
    }

    func failure() {
        print("Error")

    }
}
