//
//  PendenciesViewController.swift
//  RastreioBF
//
//  Created by Jessica Bigal on 09/09/22.
//

import UIKit

class PendenciesViewController: UIViewController {
    
    var pendenciesScreen: WarningScreen?
    
    var data : [DataProduct] = [ DataProduct(
        productName: "Shein",
        productNameImage: "truck",
        codeTraking: "PJSHGAQ#",
        productDescription: "Pagamento de taxas aduaneiras pendente",
        //        productStatusImage: "done",
        data: "19/09/2022",
        time: "18:33"),
                                 
                                 DataProduct (
                                    productName: "Drop4Me",
                                    productNameImage: "truck",
                                    codeTraking: "JAKIHSAQ#",
                                    productDescription: "Pagamento de taxas aduaneiras pendente",
                                    //        productStatusImage: "done",
                                    data: "07/09/2022",
                                    time: "01:45"),
    ]
    
    override func loadView() {
        self.pendenciesScreen = WarningScreen()
        self.view = self.pendenciesScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.navigationItem.title = LC.pendenciesTitle.text
        self.pendenciesScreen?.configTableViewProtocols(delegate: self, dataSource: self)
        
        // Do any additional setup after loading the view.
    }
    
}
    extension PendenciesViewController: UITableViewDelegate, UITableViewDataSource{
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
