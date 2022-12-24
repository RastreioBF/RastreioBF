//
//  WarningViewController.swift
//  RastreioBF
//
//  Created by Jessica Bigal on 09/09/22.
//

import UIKit
import CoreData

class WarningViewController: UIViewController{
    
    private var alert:Alert?
    private var coreData = DataProduct()
    private var eventArray = [DataProduct]()
    private var manageObjectContext: NSManagedObjectContext!
    private var viewModel = WarningViewModel()
    private var warningView: WarningView?
    
    override func loadView() {
        self.warningView = WarningView()
        self.view = self.warningView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.alert = Alert(controller: self)
        self.navigationItem.title = LC.warningTitle.text
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: LC.filter.text, style: .plain, target: self, action: #selector(filter))
        manageObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        self.loadSaveData()
        viewModel.delegate = self
        self.warningView?.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "EmptyStateTableViewCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.updatePackages()
    }
    
    func loadSaveData()  {
        let eventRequest: NSFetchRequest<DataProduct> = DataProduct.fetchRequest()
        do {
            eventArray = try manageObjectContext.fetch(eventRequest)
            warningView?.tableView.reloadData()
        } catch
        {
            print("Could not load save data: \(error.localizedDescription)")
        }
    }
    
    func configTableView(){
        warningView?.tableView.delegate = self
        warningView?.tableView.dataSource = self
    }
    
    func handle(_ result: Result<[DataProduct], Error>) {
        switch result {
        case .success(let eventArray):
            self.eventArray = eventArray
            self.warningView?.tableView.reloadData()
        case .failure(let err):
            SAlertController.showError(message: err.localizedDescription)
        }
    }

   @objc
   func filter() {
        alert?.filterState(completion: { option in
            switch option {
            case .onWay:
                self.fetchRequestWithTemplate(named: "FetchRequestOnItsWay")
            case .pendencie:
                self.fetchRequestWithTemplate(named: "FetchRequestError")
            case .done:
                self.fetchRequestWithTemplate(named: "FetchRequestDone")
            case .all:
                self.fetchRequestWithTemplate(named: "FetchRequestAll")
            case .cancel:
                break
            }
        })
    
    }
    
    func fetchRequestWithTemplate(named: String) {
        CoreDataManager.shared.fetch(requestName: named, ofType: DataProduct.self) { (result) in
            self.handle(result)
        }
    }

}

extension WarningViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let eventArrayItem = eventArray[indexPath.row]
        
        if editingStyle == .delete {
            manageObjectContext.delete(eventArrayItem)
            tableView.beginUpdates()
            viewModel.removeData(indexPath: indexPath)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
        do {
                    try manageObjectContext.save()
                } catch let error as NSError {
                    print("Error While Deleting Note: \(error.userInfo)")
                }
            }
            self.loadSaveData()
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.dataArraySize
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        if viewModel.hasData {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ProductDetailTableViewCell.identifier, for: indexPath) as? ProductDetailTableViewCell else { return UITableViewCell() }
            cell.setupCell(data: viewModel.getDataProduct(indexPath: indexPath))
            return cell
//        } else {
//            guard let cell =  tableView.dequeueReusableCell(withIdentifier: EmptyStateTableViewCell.identifier, for: indexPath) as? EmptyStateTableViewCell else { return UITableViewCell() }
//                    cell.setupCell(status: "Nada por aqui")
//            return cell
//        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.heightForRowAt
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProductDetailTableViewCell.identifier) as? ProductDetailTableViewCell
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
        alert?.getAlert(titulo: LC.atentionTitle.text, mensagem: LC.wrongCodeMessage.text)
    }
}
