//
//  PendenciesViewController.swift
//  RastreioBF
//
//  Created by Jessica Bigal on 09/09/22.
//

import UIKit

class PendenciesViewController: UIViewController {
    
    private var pendenciesView: PendenciesView?
    private var dataProductVM = PendenciesViewControllerViewModel()
    
    override func loadView() {
        self.pendenciesView = PendenciesView()
        self.view = self.pendenciesView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.navigationItem.title = LC.pendenciesTitle.text
        self.pendenciesView?.configTableViewProtocols(delegate: self, dataSource: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        pendenciesView?.tableView.reloadData()
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
                dataProductVM.removeData(indexPath: indexPath)
                tableView.deleteRows(at: [indexPath], with: .fade)
                tableView.endUpdates()
            }
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return dataProductVM.dataArraySize
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell : ProductDetailTableViewCell? = tableView.dequeueReusableCell(withIdentifier: ProductDetailTableViewCell.identifier, for: indexPath) as? ProductDetailTableViewCell
            cell?.setupCell(data: dataProductVM.getDataProduct(indexPath: indexPath))
            
            return cell ?? UITableViewCell()
        }
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return dataProductVM.heightForRowAt
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let vc : DetailViewController = DetailViewController()
            vc.data = dataProductVM.getDataProduct(indexPath: indexPath)
            present(vc, animated: true)
        }
    }
