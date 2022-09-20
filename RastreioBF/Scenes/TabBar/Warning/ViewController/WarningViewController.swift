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
    
    var data : [DataProduct] = [ DataProduct(
        productName: "Playstation",
        productNameImage: "truck",
        codeTraking: "KJSBAFQ#",
        productDescription: "Objeto encaminhado para Araçatuba/SP",
        data: "20/12/2022",
        time: "20:00"),
                                 
                                 DataProduct(
                                    productName: "TV Samsung",
                                    productNameImage: "truck",
                                    codeTraking: "AAKLMDSABR#",
                                    productDescription: "Objeto encaminhado para Fortaleza/CE ",
                                    data: "12/01/2022",
                                    time: "00:00"),
                                 
                                 DataProduct(
                                    productName: "Cabo HDMI",
                                    productNameImage: "truck",
                                    codeTraking: "KJSBA@23#",
                                    productDescription: "Objeto encaminhado para Recife/PE",
                                    data: "20/12/2022",
                                    time: "20:00"),
                                 
                                 DataProduct(
                                    productName: "Playstation",
                                    productNameImage: "truck",
                                    codeTraking: "KJSBAFQ#",
                                    productDescription: "Objeto encaminhado para Fortaleza/CE",
                                    data: "20/12/2022",
                                    time: "20:00")
                            ]
  
    //Aqui a viewController carrega a sua screen
    override func loadView() {
        self.warningScreen = WarningScreen()
        self.view = self.warningScreen
    }
    
    //Aqui a viewController apresenta sua screen
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.view.backgroundColor = .white
        self.navigationItem.title = LC.warningTitle.text
        self.warningScreen?.configTableViewProtocols(delegate: self, dataSource: self)

    }
    
}

extension WarningViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : ProductDetailTableViewCell? = tableView.dequeueReusableCell(withIdentifier: ProductDetailTableViewCell.identifier, for: indexPath) as? ProductDetailTableViewCell
        cell?.setupCell(data: self.data[indexPath.row])
        
        return cell ?? UITableViewCell()
    }
    
    // altura da cell
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 125
    }
}

