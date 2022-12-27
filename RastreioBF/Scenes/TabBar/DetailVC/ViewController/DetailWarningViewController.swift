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
    private var alert: Alert?
    
    init(code: String, descriptionClient: String) {
        super.init(nibName: nil, bundle: nil)
        viewModel.setTrackingInformation(code: code, description: description)
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
        alert = Alert(controller: self)
        viewModel.delegate(delegate: self)
        configTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.fetchPackageAlamofire(code: viewModel.trackingCode)
    }
    
    func configTableView(){
        detailWarningView?.tableView.delegate = self
        detailWarningView?.tableView.dataSource = self
    }
    
    func setData(data: DataProduct?) {
        viewModel.setData(data: data)
    }
}

extension DetailWarningViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberaOfRowsInSection
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: PackageCell? = tableView.dequeueReusableCell(withIdentifier: PackageCell.identifier, for: indexPath) as? PackageCell
        cell?.prepareCell(model: viewModel.loadCurrentDetailAccountList(indexPath: indexPath))
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.heightForRowAt
    }
}

extension DetailWarningViewController: DetailWarningViewModelProtocols {
    func success() {
        DispatchQueue.main.async {
            self.configTableView()
            self.detailWarningView?.tableView.reloadData()
        }
    }
    
    func failure() {
        alert?.getAlert(titulo: LC.atentionTitle.text, mensagem: LC.wrongCodeMessage.text)
    }
}
