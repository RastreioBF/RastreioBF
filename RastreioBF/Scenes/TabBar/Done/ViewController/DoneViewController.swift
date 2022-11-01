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
    
   static var data : [DataProduct] = [ DataProduct(
    productName: "Playstation 5",
    productNameImage: "done",
    codeTraking: "KJSBAFQ#",
    productDescription: "Entrega realizada com sucesso!",
    //productStatusImage: "done",
    data: "23/12/2022",
    time: "15:33"),
                                    
    DataProduct (
    productName: "TV Samsung",
    productNameImage: "done",
    codeTraking: "AAKLMDSABR#",
    productDescription: "Entrega realizada com sucesso!",
    //productStatusImage: "done",
    data: "13/01/2022",
    time: "14:00"),
    
    DataProduct (
    productName: "MacBook M2 Pro",
    productNameImage: "done",
    codeTraking: "LAHS24ABR#",
    productDescription: "Entrega realizada com sucesso!",
    //productStatusImage: "done",
    data: "10/02/2022",
    time: "11:45"),
                                    
                                 
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
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
        return true
        
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        
        return .delete
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            tableView.beginUpdates()
            DoneViewController.data.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DoneViewController.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : ProductDetailTableViewCell? = tableView.dequeueReusableCell(withIdentifier: ProductDetailTableViewCell.identifier, for: indexPath) as? ProductDetailTableViewCell
        cell?.setupCell(data: DoneViewController.data[indexPath.row])
        
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 125
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc : DetailScreen = DetailScreen()
        vc.data = DoneViewController.data[indexPath.row]
        present(vc, animated: true)
    }
}
