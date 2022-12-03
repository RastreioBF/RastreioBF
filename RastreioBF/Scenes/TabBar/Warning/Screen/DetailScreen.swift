//
//  DetailViewController.swift
//  RastreioBF
//
//  Created by Wesley Prado on 01/11/2022.
//

import UIKit

class DetailScreen: UIViewController{
    
    

    var warningScreen: WarningScreen?
    var warningViewController: WarningViewController?
    var data: DataProduct?
   // var dataDone: DataDone?

    
    override func loadView() {
        warningScreen = WarningScreen()
        view = warningScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        warningScreen?.configTableViewProtocols(delegate: self, dataSource: self)
    }

}

extension  DetailScreen: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ProductDetailTableViewCell? = tableView.dequeueReusableCell(withIdentifier: ProductDetailTableViewCell.identifier, for: indexPath) as? ProductDetailTableViewCell
        cell?.setupDetailCell(data: data ?? DataProduct(productName: "", productNameImage: "", codeTraking: "", productDescription: "", data: "", time: "", status: "ongoing"))
        return cell ?? UITableViewCell()
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
}
