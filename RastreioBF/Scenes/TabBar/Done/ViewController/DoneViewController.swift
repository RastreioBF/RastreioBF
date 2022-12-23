//
//  DoneViewController.swift
//  RastreioBF
//
//  Created by Jessica Bigal on 09/09/22.
//

import UIKit
import Foundation

class DoneViewController: UIViewController, Coordinating {
    var coordinator: Coordinator?
    
    private var doneView: DoneView?
    private var dataProductVM = DoneViewControllerViewModel()
    var model: Eventos?

    override func loadView() {
        self.doneView = DoneView()
        self.view = self.doneView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.navigationItem.title = LC.doneTitle.text
        self.doneView?.configTableViewProtocols(delegate: self, dataSource: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        doneView?.tableView.reloadData()
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
        let cell = tableView.dequeueReusableCell(withIdentifier: ProductDetailTableViewCell.identifier) as? ProductDetailTableViewCell
        cell?.setupCell(data: dataProductVM.getDataProduct(indexPath: indexPath))
        
        let vc = DetailWarningViewController(codigo: cell?.codeTrakingLabel.text ?? "", descriptionClient: cell?.productNameLabel.text ?? "")
        vc.data = dataProductVM.getDataProduct(indexPath: indexPath)
        navigationController?.pushViewController(vc, animated: true)
    }
}
