//
//  WarningViewController.swift
//  RastreioBF
//
//  Created by Jessica Bigal on 09/09/22.
//

import UIKit
import CoreData

let appDelegate = UIApplication.shared.delegate as? AppDelegate

class WarningViewController: UIViewController, Coordinating {
    
    private var viewModel = WarningViewControllerViewModel()
    var coordinator: Coordinator?
    var alert:Alert?
    var model: Eventos?
    var dataTRA: DataTracking?
    private var warningView: WarningView?
    var coreData = DataProduct()
    var dataDelete: [DataProduct] = []
    
    override func loadView() {
        self.warningView = WarningView()
        self.view = self.warningView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.alert = Alert(controller: self)
        self.navigationItem.title = LC.warningTitle.text
        viewModel.delegate = self
        self.configTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        viewModel.fetchPackageAlamofire(code: "6d3bb3ea2edf")
//        viewModel.fetchPackageAlamofire(code: dataTableView(<#T##tableView: UITableView##UITableView#>, cellForRowAt: <#T##IndexPath#>))
//        fetchInfosAPI()
        viewModel.updatePackages()
    }
    
    func fecthCoreDataObjects(){
//        se
    }
    
    func configTableView(){
        warningView?.tableView.delegate = self
        warningView?.tableView.dataSource = self
        warningView?.tableView.separatorStyle = .none
    }
    
    private func fetchInfosAPI() {
        let defaults = UserDefaults.standard
        let code = defaults.object(forKey: "myKey") as? [String] ?? []
        viewModel.fetchPackageAlamofire(code: code.last ?? "")
    }
}

extension WarningViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
//
//    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
//
//        let deleteAction = UITableViewRowAction(style: .destructive, title: "DELETE") { (rowAction, indexPath) in
//            self.removeCoreData(atIndexPath: indexPath)
//            self.fetchInfosAPI()
//            tableView.deleteRows(at: [indexPath], with: .automatic)
//
//        }
//
//        return deleteAction
//    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "DELETE") { (rowAction, indexPath) in
            self.removeCoreData(atIndexPath: indexPath)
            self.fetchInfosAPI()
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
        }
        
        return [deleteAction]
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            viewModel.removeData(indexPath: indexPath)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
        }
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.dataArraySize
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProductDetailTableViewCell.identifier, for: indexPath) as? ProductDetailTableViewCell else { return UITableViewCell() }
        let lastEvent = viewModel.loadCurrentDetailAccountList()
        
//        cell.setupCell(data: viewModel.getDataProduct(indexPath: indexPath), model: lastEvent)
        cell.setupCell(data: viewModel.getDataProduct(indexPath: indexPath))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.heightForRowAt
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProductDetailTableViewCell.identifier, for: indexPath) as? ProductDetailTableViewCell
//        cell?.setupCell(data: viewModel.getDataProduct(indexPath: indexPath), model: viewModel.loadCurrentDetailAccountList())
        cell?.setupCell(data: viewModel.getDataProduct(indexPath: indexPath))
        
        let vc = DetailWarningViewController(codigo: cell?.codeTrakingLabel.text ?? "", descriptionClient: cell?.productNameLabel.text ?? "")
        vc.data = viewModel.getDataProduct(indexPath: indexPath)
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension WarningViewController: WarningViewModelProtocols {
    func didUpdatePackages() {
        DispatchQueue.main.async {
            self.configTableView()
            self.warningView?.tableView.reloadData()
        }
    }
    
    func success() {
        DispatchQueue.main.async {
            self.configTableView()
            self.warningView?.tableView.reloadData()
        }
    }
    
    func failure() {
        alert?.getAlert(titulo: "Atencao", mensagem: "Um erro ocorreu, verifique o codigo digitado e/ou sua conexao com a internet.")
    }
}

extension WarningViewController{
    func removeCoreData(atIndexPath indexpath: IndexPath){
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        
        managedContext.delete(viewModel.getDataProduct(indexPath: indexpath))
        do {
            try managedContext.save()
        } catch {
            debugPrint("could not remove: \(error.localizedDescription)")
        }
    }
}
