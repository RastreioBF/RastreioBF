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
        trackingView = TrackingView()
        view = trackingView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = LC.homeTitle.text
        navigationItem.titleView?.tintColor = .systemBlue
        trackingView?.configTextFieldDelegate(delegate: self)
        trackingView?.delegate(delegate: self)
        alert = Alert(controller: self)
        configTapGesture()
        viewModel.accessDelegate(delegate: self)
    }
    
    private func configTapGesture(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func handleTap(){
        view.endEditing(true)
    }
}

extension TrackingViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let nextTextField = trackingView?.viewWithTag(textField.tag + 1) as? UITextField {
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
                alert?.getAlert(titulo: LC.atentionTitle.text, mensagem: LC.dataMustBeFilledMessage.text)
            }
        } else {
            alert?.getAlert(titulo: LC.atentionTitle.text, mensagem: LC.alreadyRegisteredMessage.text)
        }
    }
    
    internal func actionBackButton() {
        let viewController = LoginViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }
}

extension TrackingViewController: TrackingViewModelDelegate {
    
    func didUpdatePackages() {
        //to be implemented
    }
    
    internal func success() {
        let trackingNumber = trackingView?.trackingNumberTextField.text ?? ""
        let name = trackingView?.descriptionTextField.text ?? ""
        
        viewModel.addPackage(name: name, trackingNumber: trackingNumber)
        alert?.getAlert(titulo: LC.dataSalvedTitle.text, mensagem: LC.dataSavedMessage.text, completion: {
        })
        trackingView?.trackingNumberTextField.text = ""
        trackingView?.descriptionTextField.text = ""
    }
    
    internal func failure() {
        alert?.getAlert(titulo: LC.atentionTitle.text, mensagem:LC.wrongCodeMessage.text)
    }
}
