//
//  TrackingViewController.swift
//  MyProjectScreens
//
//  Created by Anderson Sales on 28/10/22.
//

import UIKit

protocol TrackingDelegate {
    func didAddPackage(name: String, trackingNumber: String)
}

class TrackingViewController: UIViewController, Coordinating {
    var coordinator: Coordinator?
    
    var delegate: TrackingDelegate?
    private var trackingView: TrackingView?
    private var alert: Alert?
    private var dataProductVM = TrackingViewControllerViewModel()
    
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
    }

    private func configTapGesture(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func handleTap(){
        view.endEditing(true)
    }
    
    private func saveCodeTracking(code: String) {
//        let defaults = UserDefaults.standard
//        defaults.set(code, forKey: "codeTracking")
        // Access Shared Defaults Object
        let userDefaults = UserDefaults.standard

        var strings: [String] = userDefaults.object(forKey: "myKey") as? [String] ?? []
        strings.append(code)
        userDefaults.set(strings, forKey: "myKey")
    }
}

extension TrackingViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.trackingView?.validateTextFields()
    }
    
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
    
//    func didAddPackage(name: String, trackingNumber: String) {
//        viewModel?.addPackage(name: name, trackingNumber: trackingNumber)
//    }
    
    func actionSubmitButton() {
        if checkTextFieldsAreNotEmpty() {

            dataProductVM.setupDataProduct(data: DataProduct(productName: self.trackingView?.descriptionTextField.text ?? "", productNameImage: "new", codeTraking: self.trackingView?.trackingNumberTextField.text ?? "", productDescription: "Novo(a) \(self.trackingView?.descriptionTextField.text ?? "")", date: "01/11/2022", time: "20:30", status: self.trackingView?.statusTextField.text ?? ""))
            
            dataProductVM.setupDataProduct(data: DataProduct(productName: self.trackingView?.descriptionTextField.text ?? "", productNameImage: "new", codeTraking: self.trackingView?.trackingNumberTextField.text ?? "", productDescription: "Novo(a) \(self.trackingView?.descriptionTextField.text ?? "")", date: "01/11/2022", time: "20:30", status: self.trackingView?.statusTextField.text ?? ""))
            
            self.delegate?.didAddPackage(name: self.trackingView?.trackingNumberTextField.text ?? "", trackingNumber: self.trackingView?.descriptionTextField.text ?? "")
            
            dataProductVM.setupDataTracking(dataTracking: DataTracking(code: self.trackingView?.trackingNumberTextField.text ?? "", description: self.trackingView?.descriptionTextField.text ?? ""))
            
            dataProductVM.populateCorrectArray(data: dataProductVM.getLastData(), model: dataProductVM.getLastDataHeader())
            
            dataProductVM.addPackage(name: self.trackingView?.descriptionTextField.text ?? "", trackingNumber: self.trackingView?.trackingNumberTextField.text ?? "")
     
    
            saveCodeTracking(code: self.trackingView?.trackingNumberTextField.text ?? "")
            self.alert?.getAlert(titulo: "Dados Salvos!", mensagem: "Seus dados de rastreio foram salvos com sucesso!", completion: {
                let vc: WarningViewController = WarningViewController()
                self.navigationController?.pushViewController(vc, animated: true)
            })
            
            self.trackingView?.trackingNumberTextField.text = ""
            self.trackingView?.descriptionTextField.text = ""
            self.trackingView?.statusTextField.text = ""
                       
        } else {
            self.alert?.getAlert(titulo: "Atenção!", mensagem: "Todos os campos precisam ser preenchidos para que os dados possam ser salvos!")
        }
    }
    
    func actionBackButton() {
        let viewController = LoginViewController()
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func checkTextFieldsAreNotEmpty() -> Bool {
        let trackingNumber = self.trackingView?.trackingNumberTextField.text ?? ""
        let description = self.trackingView?.descriptionTextField.text ?? ""
        let status = self.trackingView?.statusTextField.text ?? ""
        
        if trackingNumber.isEmpty || trackingNumber.hasPrefix(" ") || description.isEmpty || description.hasPrefix(" ") || status.isEmpty || status.hasPrefix(" "){
            return false
        }
        return true
    }
}
