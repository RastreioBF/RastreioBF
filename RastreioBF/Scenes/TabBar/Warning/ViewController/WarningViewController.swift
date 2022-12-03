//
//  WarningViewController.swift
//  RastreioBF
//
//  Created by Jessica Bigal on 09/09/22.
//

import UIKit
import Foundation

class WarningViewController: UIViewController {
    
    //Aqui voce apresenta sua screen para a viewController
    var warningScreen: WarningScreen?
    var dataProductVM = WarningViewControllerViewModel()
    
    //Aqui a viewController carrega a sua screen
    override func loadView() {
        self.warningScreen = WarningScreen()
        self.view = self.warningScreen
    }
    
    //Aqui a viewController apresenta sua screen
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = LC.warningTitle.text
        self.warningScreen?.configTableViewProtocols(delegate: self, dataSource: self)
    }
    
    /*func insertRows(data: DataProduct?){
        dataProductVM.setupDataProduct(data: data ?? DataProduct(productName: "NA", productNameImage: "NA", codeTraking: "NA", productDescription: "NA", data: "NA", time: "NA", status: ""))
    }*/
    
    override func viewWillAppear(_ animated: Bool) {
        warningScreen?.tableView.reloadData()
    }
}

extension WarningViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            dataProductVM.removeData(indexPath: indexPath)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataProductVM.dataArraySize == 0 ? 1 : dataProductVM.dataArraySize
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : ProductDetailTableViewCell? = tableView.dequeueReusableCell(withIdentifier: ProductDetailTableViewCell.identifier, for: indexPath) as? ProductDetailTableViewCell
        cell?.setupCell(data: dataProductVM.getDataProduct(indexPath: indexPath))
        return cell ?? UITableViewCell()
    }
    
    // altura da cell
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return dataProductVM.heightForRowAt
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc : DetailScreen = DetailScreen()
        vc.data = dataProductVM.getDataProduct(indexPath: indexPath)
        present(vc, animated: true)
    }
}

