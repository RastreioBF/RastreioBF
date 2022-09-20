//
//  DoneViewController.swift
//  RastreioBF
//
//  Created by Jessica Bigal on 09/09/22.
//

import UIKit
import Foundation

class DoneViewController: UIViewController {

    var doneScreen: WarningScreen?
    
    var data : [DataProduct] = [ DataProduct(
        productName: "Playstation 5",
        productNameImage: "truck",
        codeTraking: "KJSBAFQ#",
        productDescription: "Entrega realizada com sucesso!",
//        productStatusImage: "done",
        data: "23/12/2022",
        time: "15:33"),
                                 
        DataProduct (
        productName: "TV Samsung",
        productNameImage: "post",
        codeTraking: "AAKLMDSABR#",
        productDescription: "Entrega realizada com sucesso!",
//        productStatusImage: "done",
        data: "13/01/2022",
        time: "14:00"),
    ]

    override func loadView() {
        self.doneScreen = WarningScreen()
        self.view = self.doneScreen
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.navigationItem.title = LC.doneTitle.text
        self.doneScreen?.configTableViewProtocols(delegate: self, dataSource: self)

        // Do any additional setup after loading the view.
    }

}

extension DoneViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : ProductDetailTableViewCell? = tableView.dequeueReusableCell(withIdentifier: ProductDetailTableViewCell.identifier, for: indexPath) as? ProductDetailTableViewCell
        cell?.setupCell(data: self.data[indexPath.row])
        
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 125
    }
}
