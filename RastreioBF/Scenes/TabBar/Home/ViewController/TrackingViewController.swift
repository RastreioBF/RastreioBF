//
//  TrackingViewController.swift
//  MyProjectScreens
//
//  Created by Anderson Sales on 28/10/22.
//

import UIKit

class TrackingViewController: UIViewController {
    
    var trackingView: TrackingView?
    var alert: Alert?
    var warningViewController: WarningViewController?
    var dataProductVM = TrackingViewControllerViewModel()
    
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
    // Abaixa o teclado independente de onde eu clico
    private func configTapGesture(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func handleTap(){
        view.endEditing(true)
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
    func actionEmailNotificationSwitch() {
    }
    
    func actionSendNoticationToAnotherEmailButton() {
        let viewController = EmailNotificationViewController()
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func actionSubmitButton() {
        // Funcao disparada quando o botao salvar é acionado
        if checkTextFieldsAreNotEmpty() {
            
            dataProductVM.setupDataProduct(data: DataProduct(productName: self.trackingView?.descriptionTextField.text ?? "", productNameImage: "new", codeTraking: self.trackingView?.trackingNumberTextField.text ?? "", productDescription: "Novo(a) \(self.trackingView?.descriptionTextField.text ?? "")", data: "01/11/2022", time: "20:30", status: self.trackingView?.statusTextField.text ?? ""))
            
            dataProductVM.populateCorrectArray(data: dataProductVM.getLastData())
     
            self.alert?.getAlert(titulo: "Dados Salvos!", mensagem: "Seus dados de rastreio foram salvos com sucesso!")
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
        
        if trackingNumber.isEmpty || trackingNumber.hasPrefix(" ") || description.isEmpty || description.hasPrefix(" "){
            return false
        }
        return true
    }
}
