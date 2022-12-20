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
    var dataHeader: DataTracking?
    var model: Eventos?
    
    override func loadView() {
        detailDoneView = DetailDoneView()
        view = detailDoneView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailDoneView?.configTableViewProtocols(delegate: self, dataSource: self)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        hidesBottomBarWhenPushed = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension  DetailDoneViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ProductDetailTableViewCell? = tableView.dequeueReusableCell(withIdentifier: ProductDetailTableViewCell.identifier, for: indexPath) as? ProductDetailTableViewCell
        cell?.setupDetailCell(data: DataProduct())
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return dataProductVM.heightForRowAt
    }
}
