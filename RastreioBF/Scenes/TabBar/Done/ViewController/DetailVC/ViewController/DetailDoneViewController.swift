//
//  DetailDoneViewController.swift
//  RastreioBF
//
//  Created by Anderson Sales on 04/12/22.
//

import UIKit

class DetailDoneViewController: UIViewController{
    
    private var detailDoneView: DetailDoneView?
    private var dataProductVM = DetailDoneControllerViewModel()
    var data: DataProduct?
    
    override func loadView() {
        detailDoneView = DetailDoneView()
        view = detailDoneView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailDoneView?.configTableViewProtocols(delegate: self, dataSource: self)
    }
}

extension  DetailDoneViewController: UITableViewDataSource, UITableViewDelegate {
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
