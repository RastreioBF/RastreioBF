//
//  WarningViewController.swift
//  RastreioBF
//
//  Created by Jessica Bigal on 09/09/22.
//

import UIKit
import CoreData

class WarningViewController: UIViewController{
    
    private var alert: Alert?
    private var manageObjectContext: NSManagedObjectContext?
    private var viewModel = WarningViewModel()
    private var warningView: WarningView?
    
    override func loadView() {
        warningView = WarningView()
        view = warningView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        alert = Alert(controller: self)
        configNavigation()
        manageObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        viewModel.delegate(delegate: self)
        hideTableViewData()
        warningView?.tableViewEmpty.separatorStyle = .none
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configTableView()
        viewModel.updatePackages()
        hideTableViewData()
    }
    
    private func configNavigation(){
        navigationItem.title = LC.warningTitle.text
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: LC.filterIcon.text), style: .plain, target: self, action: #selector(filter))
    }
    
    private func loadSaveData()  {
        let eventRequest: NSFetchRequest<DataProduct> = DataProduct.fetchRequest()
        do {
            let event = try manageObjectContext?.fetch(eventRequest)
            viewModel.setEventArray(eventArray: event ?? [DataProduct]())
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
    private func filter() {
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
    
    private func hideTableViewData(){
        if viewModel.dataArraySize != 0 {
            warningView?.tableViewData.isHidden = false
            warningView?.tableViewEmpty.isHidden = true
        } else {
            warningView?.tableViewData.isHidden = true
            warningView?.tableViewEmpty.isHidden = false
        }
    }
}

extension WarningViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let eventArrayItem = viewModel.getEventArray(indexPath: indexPath)
        
        if editingStyle == .delete {
            manageObjectContext?.delete(eventArrayItem)
            tableView.beginUpdates()
            viewModel.removeData(indexPath: indexPath)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
            do {
                try manageObjectContext?.save()
            } catch let error as NSError {
                print("Error While Deleting Note: \(error.userInfo)")
            }
        }
        loadSaveData()
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
            
            let vc = DetailWarningViewController(code: cell?.codeTrakingLabel.text ?? "", descriptionClient: cell?.productNameLabel.text ?? "")
            vc.setData(data: viewModel.getDataProduct(indexPath: indexPath))
            vc.title = viewModel.getDataProduct(indexPath: indexPath).productDescription
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
