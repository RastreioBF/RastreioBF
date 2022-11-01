//
//  PendenciesViewController.swift
//  RastreioBF
//
//  Created by Jessica Bigal on 09/09/22.
//

import UIKit

class PendenciesViewController: UIViewController {
    
    var pendenciesScreen: WarningScreen?
    
    static var data : [DataProduct] = [ DataProduct(
        productName: "Shein",
        productNameImage: "pendencias",
        codeTraking: "PJSHGAQ#",
        productDescription: "Pagamento de taxas aduaneiras pendente",
        //        productStatusImage: "done",
        data: "19/09/2022",
        time: "18:33"),
                                 
                                 DataProduct (
                                    productName: "Drop4Me",
                                    productNameImage: "pendencias",
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
        
        
        func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
            
            return true
            
        }
        
    
        func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
            
            return .delete
            
        }
        
        
        
        func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            
            if editingStyle == .delete {
                
                tableView.beginUpdates()
                
                PendenciesViewController.data.remove(at: indexPath.row)
                
                tableView.deleteRows(at: [indexPath], with: .fade)
                
                tableView.endUpdates()
                
            }
            
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return PendenciesViewController.data.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell : ProductDetailTableViewCell? = tableView.dequeueReusableCell(withIdentifier: ProductDetailTableViewCell.identifier, for: indexPath) as? ProductDetailTableViewCell
            cell?.setupCell(data: PendenciesViewController.data[indexPath.row])
            
            return cell ?? UITableViewCell()
        }
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 125
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let vc : DetailScreen = DetailScreen()
            vc.data = PendenciesViewController.data[indexPath.row]
            present(vc, animated: true)
        }
    }
