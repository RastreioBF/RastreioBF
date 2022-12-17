//
//  WarningViewController.swift
//  RastreioBF
//
//  Created by Jessica Bigal on 09/09/22.
//

import UIKit

class WarningViewController: UIViewController, Coordinating {
    
    private var viewModel = WarningViewControllerViewModel()
    var coordinator: Coordinator?
    var alert:Alert?
    var model: Eventos?
    var dataTRA: DataTracking?
    private var warningView: WarningView?
    private var dataProductVM = WarningViewControllerViewModel()
    
//    var codigo: String?
//    var descriptionClient: String?

//    init(codigo: String?, descriptionClient: String?) {
//        self.codigo = codigo
//        self.descriptionClient = descriptionClient
//        super.init(nibName: nil, bundle: nil)
//    }
    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    override func loadView() {
        self.warningView = WarningView()
        self.view = self.warningView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.alert = Alert(controller: self)
        self.navigationItem.title = LC.warningTitle.text
        viewModel.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.fetchPackageAlamofire(code: "6d3bb3ea2edf")
    }
    
    func configTableView(){
        warningView?.tableView.delegate = self
        warningView?.tableView.dataSource = self
        warningView?.tableView.separatorStyle = .none
    }
}

extension WarningViewController: UITableViewDelegate, UITableViewDataSource{
    
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProductDetailTableViewCell.identifier, for: indexPath) as? ProductDetailTableViewCell else { return UITableViewCell() }
        cell.setupCell(data: dataProductVM.getDataProduct(indexPath: indexPath))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return dataProductVM.heightForRowAt
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell : ProductDetailTableViewCell? = tableView.dequeueReusableCell(withIdentifier: ProductDetailTableViewCell.identifier, for: indexPath) as? ProductDetailTableViewCell
        cell?.setupCell(data: dataProductVM.getDataProduct(indexPath: indexPath))
    
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProductDetailTableViewCell.identifier, for: indexPath) as? ProductDetailTableViewCell else { return }
        let vc = DetailWarningViewController(codigo: cell?.codeTrakingLabel.text ?? "", descriptionClient: cell?.productNameLabel.text ?? "")
        vc.data = dataProductVM.getDataProduct(indexPath: indexPath)
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension WarningViewController: WarningViewModelProtocols {
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

