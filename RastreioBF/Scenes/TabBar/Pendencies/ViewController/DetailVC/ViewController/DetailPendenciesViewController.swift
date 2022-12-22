//
//  DetailPendenciesViewController.swift
//  RastreioBF
//
//  Created by Anderson Sales on 04/12/22.
//

import UIKit

class DetailPendenciesViewController: UIViewController{
    
    private var detailPendenciesView: DetailPendenciesView?
    private var dataProductVM = DetailPendenciesControllerViewModel()
    var data: DataProduct?
    var dataHeader: DataTracking?
    var model: Eventos?
    
    override func loadView() {
        detailPendenciesView = DetailPendenciesView()
        view = detailPendenciesView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        detailPendenciesView?.configTableViewProtocols(delegate: self, dataSource: self)
    }
    
    func configTableView(){
        detailPendenciesView?.tableView.delegate = self
        detailPendenciesView?.tableView.dataSource = self
        detailPendenciesView?.tableView.separatorStyle = .none
    }
}

extension  DetailPendenciesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ProductDetailTableViewCell? = tableView.dequeueReusableCell(withIdentifier: ProductDetailTableViewCell.identifier, for: indexPath) as? ProductDetailTableViewCell
//        cell?.setupDetailCell(data: data ?? DataProduct(productName: "", productNameImage: "", codeTraking: "", productDescription: "", date: "", time: "", status: ""))
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return dataProductVM.heightForRowAt
    }
}
