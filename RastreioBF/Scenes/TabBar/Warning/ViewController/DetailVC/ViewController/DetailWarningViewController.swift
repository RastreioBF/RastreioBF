//
//  DetailWarningViewController.swift
//  RastreioBF
//
//  Created by Anderson Sales on 04/12/22.
//

import UIKit

class DetailWarningViewController: UIViewController {
    
    private var detailWarningView: DetailWarningView?
    private var dataProductVM = DetailWarningViewControllerViewModel()
    var data: DataProduct?
    
    override func loadView() {
        detailWarningView = DetailWarningView()
        view = detailWarningView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailWarningView?.configTableViewProtocols(delegate: self, dataSource: self)
    }
}

extension  DetailWarningViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ProductDetailTableViewCell? = tableView.dequeueReusableCell(withIdentifier: ProductDetailTableViewCell.identifier, for: indexPath) as? ProductDetailTableViewCell
        cell?.setupDetailCell(data: data ?? DataProduct(productName: "", productNameImage: "", codeTraking: "", productDescription: "", date: "", time: "", status: ""))
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return dataProductVM.heightForRowAt
    }
}
