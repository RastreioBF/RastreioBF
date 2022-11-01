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
    //var newData: DataProduct?
    
    static var data : [DataProduct] = [DataProduct(
        productName: "Playstation 5",
        productNameImage: "truck",
        codeTraking: "KJSBAFQ#",
        productDescription: "Objeto encaminhado para Araçatuba/SP",
        data: "20/12/2022",
        time: "20:00"),
                                       
                                       DataProduct(
                                        productName: "TV Samsung",
                                        productNameImage: "post",
                                        codeTraking: "AAKLMDSABR#",
                                        productDescription: "Objeto encaminhado para Fortaleza/CE ",
                                        data: "12/01/2022",
                                        time: "00:00"),
                                       
                                       DataProduct(
                                        productName: "Cabo HDMI",
                                        productNameImage: "airplane",
                                        codeTraking: "KJSBA@23#",
                                        productDescription: "Objeto encaminhado para Recife/PE",
                                        data: "20/12/2022",
                                        time: "20:00"),
                                       
                                       DataProduct(
                                        productName: "Ipad M2",
                                        productNameImage: "truck",
                                        codeTraking: "AHISBAFQ#",
                                        productDescription: "Objeto encaminhado para Fortaleza/CE",
                                        data: "08/10/2022",
                                        time: "10:34")
    ]
    
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
    
    func insertRows(data: DataProduct?){
        WarningViewController.data.append(data ?? DataProduct(productName: "NA", productNameImage: "NA", codeTraking: "NA", productDescription: "NA", data: "NA", time: "NA"))
    }
    
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
            WarningViewController.data.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return WarningViewController.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : ProductDetailTableViewCell? = tableView.dequeueReusableCell(withIdentifier: ProductDetailTableViewCell.identifier, for: indexPath) as? ProductDetailTableViewCell
        cell?.setupCell(data: WarningViewController.data[indexPath.row])
        return cell ?? UITableViewCell()
    }
    
    // altura da cell
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 125
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc : DetailScreen = DetailScreen()
        vc.data = WarningViewController.data[indexPath.row]
        present(vc, animated: true)
    }
}

