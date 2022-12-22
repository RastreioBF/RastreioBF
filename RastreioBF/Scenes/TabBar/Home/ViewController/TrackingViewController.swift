//
//  TrackingViewController.swift
//  MyProjectScreens
//
//  Created by Anderson Sales on 28/10/22.
//

import UIKit

class TrackingViewController: UIViewController{
    
    private var trackingView: TrackingView?
    private var alert: Alert?
    private var viewModel = TrackingViewControllerViewModel()

    override func loadView() {
        self.trackingView = TrackingView()
        self.view = self.trackingView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.navigationItem.title = LC.homeTitle.text
        self.navigationItem.titleView?.tintColor = .systemBlue
        self.trackingView?.configTextFieldDelegate(delegate: self)
        self.trackingView?.delegate(delegate: self)
        self.alert = Alert(controller: self)
        self.configTapGesture()
        self.viewModel.delegate = self
    }

    private func configTapGesture(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func handleTap(){
        view.endEditing(true)
    }

}

extension TrackingViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let nextTextField = self.trackingView?.viewWithTag(textField.tag + 1) as? UITextField {
            nextTextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return true
    }
}

extension TrackingViewController: TrackingViewProtocol{
    
    func actionSubmitButton() {
        let trackingNumber = trackingView?.trackingNumberTextField.text ?? ""
        let name = trackingView?.descriptionTextField.text ?? ""
        
        if CoreDataManager.shared.updateData(codeTracking: trackingNumber){
            if viewModel.checkTextFieldsAreNotEmpty(name: name, trackingNumber: trackingNumber){
                viewModel.fetchHistory(code: trackingNumber)
            } else {
                self.alert?.getAlert(titulo: "Atenção!", mensagem: "Todos os campos precisam ser preenchidos para que os dados possam ser salvos!")
            }
        } else {
            self.alert?.getAlert(titulo: "Atenção!", mensagem: "Rastreio já cadastrado, insira um novo código.")
        }
    }
    
    func actionBackButton() {
        let viewController = LoginViewController()
        self.navigationController?.pushViewController(viewController, animated: true)
    }

}

extension TrackingViewController: TrackingViewModelDelegate {
    
    func didUpdatePackages() {
        //to be implemented
        
    }
    
    func success() {
        let trackingNumber = self.trackingView?.trackingNumberTextField.text ?? ""
        let name = self.trackingView?.descriptionTextField.text ?? ""
        
            viewModel.addPackage(name:name, trackingNumber: trackingNumber)
            self.alert?.getAlert(titulo: "Dados Salvos!", mensagem: "Seus dados de rastreio foram salvos com sucesso!", completion: {
                let vc: WarningViewController = WarningViewController()
                self.navigationController?.pushViewController(vc, animated: true)
            })
            self.trackingView?.trackingNumberTextField.text = ""
            self.trackingView?.descriptionTextField.text = ""
    }
    
    func failure() {
        self.alert?.getAlert(titulo: "Atenção!", mensagem:"Verique o codigo de rastreio inserido e/ou sua conexao com a internet.")
    }
}
