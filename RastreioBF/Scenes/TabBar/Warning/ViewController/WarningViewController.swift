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
    var coreDataStack = CoreDataStack(modelName: LC.dataProduct.text)
    var eventArray = [DataProduct]()
    private var manageObjectContext: NSManagedObjectContext!
    private var viewModel = WarningViewModel()
    private var warningView: WarningView?
    
    override func loadView() {
        self.warningView = WarningView()
        self.view = self.warningView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        alert = Alert(controller: self)
        naviagtionSetup()
        manageObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        viewModel.delegate = self
        hideTableViewData()
        warningView?.tableViewEmpty.separatorStyle = .none
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configTableView()
        viewModel.updatePackages()
        hideTableViewData()
    }
    
    func naviagtionSetup(){
        navigationItem.title = LC.warningTitle.text
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: LC.filterIcon.text), style: .plain, target: self, action: #selector(filter))
    }
    
    func loadSaveData()  {
        let eventRequest: NSFetchRequest<DataProduct> = DataProduct.fetchRequest()
        do {
            eventArray = try manageObjectContext.fetch(eventRequest)
            warningView?.tableViewData.reloadData()
        } catch
        {
            print("Could not load save data: \(error.localizedDescription)")
        }
    }
    
    func configTableView(){
        warningView?.tableViewData.delegate = self
        warningView?.tableViewData.dataSource = self
        warningView?.tableViewEmpty.delegate = self
        warningView?.tableViewEmpty.dataSource = self
    }
    
    @objc
    func filter() {
        alert?.filterState(completion: { option in
            switch option {
            case .onWay:
                self.viewModel.fetchRequestWithTemplate(named: "FetchRequestOnItsWay")
            case .pendencie:
                self.viewModel.fetchRequestWithTemplate(named: "FetchRequestError")
            case .done:
                self.viewModel.fetchRequestWithTemplate(named: "FetchRequestDone")
            case .all:
                self.viewModel.fetchRequestWithTemplate(named: "FetchRequestAll")
            case .cancel:
                break
            }
        })
    }
    
    func hideTableViewData(){
        if viewModel.dataArraySize != 0 {
            self.warningView?.tableViewData.isHidden = false
            self.warningView?.tableViewEmpty.isHidden = true
        } else {
            self.warningView?.tableViewData.isHidden = true
            self.warningView?.tableViewEmpty.isHidden = false
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
        hideTableViewData()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let checks = tableView == warningView?.tableViewData ? viewModel.dataArraySize : 1
        return checks
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView != warningView?.tableViewData {
            guard let cell =  tableView.dequeueReusableCell(withIdentifier: EmptyStateTableViewCell.identifier, for: indexPath) as? EmptyStateTableViewCell else { return UITableViewCell() }
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ProductDetailTableViewCell.identifier, for: indexPath) as? ProductDetailTableViewCell else { return UITableViewCell() }
            cell.setupCell(data: viewModel.getDataProduct(indexPath: indexPath))
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.heightForRowAt
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == warningView?.tableViewData {
            let cell = tableView.dequeueReusableCell(withIdentifier: ProductDetailTableViewCell.identifier) as? ProductDetailTableViewCell
            cell?.setupCell(data: viewModel.getDataProduct(indexPath: indexPath))
            
            let vc = DetailWarningViewController(codigo: cell?.codeTrakingLabel.text ?? "", descriptionClient: cell?.productNameLabel.text ?? "")
            vc.data = viewModel.getDataProduct(indexPath: indexPath)
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension WarningViewController: WarningViewModelProtocols {
    func didUpdatePackages() {
        DispatchQueue.main.async {
            self.configTableView()
            self.loadSaveData()
            self.warningView?.tableViewData.reloadData()
        }
    }
    
    func success() {
        DispatchQueue.main.async {
            self.configTableView()
            self.hideTableViewData()
            self.warningView?.tableViewData.reloadData()
        }
    }
    
    func failure() {
        alert?.getAlert(titulo: LC.atentionTitle.text, mensagem: LC.wrongCodeMessage.text)
    }
}
