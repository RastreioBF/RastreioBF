//
//  DetailViewController.swift
//  RastreioBF
//
//  Created by Wesley Prado on 01/11/2022.
//

import UIKit

class DetailViewController: UIViewController{
    
    private var detailView: DetailView?
    private var dataProductVM = DetailViewControllerViewModel()
    
    override func loadView() {
        detailView = DetailView()
        view = detailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailView?.configTableViewProtocols(delegate: self, dataSource: self)
    }
}

extension  DetailViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ProductDetailTableViewCell? = tableView.dequeueReusableCell(withIdentifier: ProductDetailTableViewCell.identifier, for: indexPath) as? ProductDetailTableViewCell
        cell?.setupDetailCell(data: dataProductVM.getDataProduct(indexPath: indexPath))
        return cell ?? UITableViewCell()
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return dataProductVM.heightForRowAt
    }
}
