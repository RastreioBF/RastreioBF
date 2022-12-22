//
//  PendenciesViewController.swift
//  RastreioBF
//
//  Created by Jessica Bigal on 09/09/22.
//

import UIKit
import CoreData

class PendenciesViewController: UIViewController, Coordinating {
    var coordinator: Coordinator?
    
    private var pendenciesView: PendenciesView?
    private var viewModel = PendenciesViewModel()
    var coreData = DataProduct()
    var eventArray = [DataProduct]()
    var manageObjectContext: NSManagedObjectContext!
    
    override func loadView() {
        self.pendenciesView = PendenciesView()
        self.view = self.pendenciesView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.navigationItem.title = LC.pendenciesTitle.text
        manageObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        self.loadSaveData()
        viewModel.delegate = self
        configTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.updatePackages()
        configTableView()
    }
    
    func loadSaveData()  {
        let eventRequest: NSFetchRequest<DataProduct> = DataProduct.fetchRequest()
        do{
            eventArray = try manageObjectContext.fetch(eventRequest)
            pendenciesView?.tableView.reloadData()
        }catch
        {
            print("Could not load save data: \(error.localizedDescription)")
        }
    }
    
    func configTableView(){
        pendenciesView?.tableView.delegate = self
        pendenciesView?.tableView.dataSource = self
    }
    
}
extension PendenciesViewController: UITableViewDelegate, UITableViewDataSource{
    
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProductDetailTableViewCell.identifier, for: indexPath) as? ProductDetailTableViewCell else { return UITableViewCell() }
        cell.setupCell(data: viewModel.getDataProduct(indexPath: indexPath))
        return cell
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

extension PendenciesViewController: PendenciesViewModelProtocols {
    func success() {
        DispatchQueue.main.async {
            self.configTableView()
            self.pendenciesView?.tableView.reloadData()
        }
    }
    
    func failure() {
        //code
    }
    
    func didUpdatePackages() {
        DispatchQueue.main.async {
            self.configTableView()
            self.pendenciesView?.tableView.reloadData()
        }
        
    }
}
