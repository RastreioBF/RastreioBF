//
//  EmailNotificationViewController.swift
//  MyProjectScreens
//
//  Created by Anderson Sales on 28/10/22.
//

import UIKit

class EmailNotificationViewController: UIViewController {
    
    var emailNotificationView: EmailNotificationView?
    var alert: Alert?
    
    override func loadView() {
        self.emailNotificationView = EmailNotificationView()
        self.view = self.emailNotificationView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.emailNotificationView?.configTextFieldDelegate(delegate: self)
        self.emailNotificationView?.delegate(delegate: self)
        self.alert = Alert(controller: self)
        self.emailNotificationView?.delegate = self
        self.emailNotificationView?.emailErrorLabel.isHidden = true
        self.setupKeyboardHiding()
        self.configTapGesture()
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        hidesBottomBarWhenPushed = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupKeyboardHiding() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    public func validateEmailId(emailID: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
        let trimmedString = emailID.trimmingCharacters(in: .whitespaces)
        let validateEmail = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let isValidateEmail = validateEmail.evaluate(with: trimmedString)
        return isValidateEmail
    }
}

extension EmailNotificationViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.emailNotificationView?.validateTextFields()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension EmailNotificationViewController: EmailNotificationViewProtocol{
    
    func didTapEmail() {
        let text =  self.emailNotificationView?.emailTextField.text ?? ""
        let label =  self.emailNotificationView?.emailErrorLabel
        
        if text.isEmpty || text.hasPrefix(" ") {
            label?.text = "Por favor, insira seu e-mail"
            label?.isHidden = false
        } else if validateEmailId(emailID: text) == false {
            label?.text = "O e-mail deve ter o formato: nome@exemplo.com"
            label?.isHidden = false
        } else {
            label?.isHidden = true
        }
    }
    
    func actionBackButton() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func actionConfirmationButton() {
        if checkEmailTextFieldIsnotEmpty(){
            alert?.getAlert(titulo: "Tudo certo!", mensagem: "Email cadastrado com sucesso!", completion: actionBackButton)
        } else {
            alert?.getAlert(titulo: "Atenção!", mensagem: "Por favor insira um email para cadastro!")
        }
    }
}

extension EmailNotificationViewController {
    @objc func keyboardWillShow(sender: NSNotification) {
        guard let userInfo = sender.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue,
              let currentTextField = UIResponder.currentFirst() as? UITextField else { return }
        
        let keyboardTopY = keyboardFrame.cgRectValue.origin.y
        let convertedTextFieldFrame = view.convert(currentTextField.frame, from: currentTextField.superview)
        let textFieldBottomY = convertedTextFieldFrame.origin.y + convertedTextFieldFrame.size.height
        
        if textFieldBottomY > keyboardTopY {
            let textBoxY = convertedTextFieldFrame.origin.y
            let newFrameY = (textBoxY - keyboardTopY / 1.25) * -1
            view.frame.origin.y = newFrameY
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
          view.frame.origin.y = 0
      }
    
    func checkEmailTextFieldIsnotEmpty() -> Bool {
        let text = emailNotificationView?.emailTextField.text ?? ""
        
        if text.isEmpty || text.hasPrefix(" "){
            return false
        } else {
            return true
        }
    }
    
    private func configTapGesture(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func handleTap(){
        view.endEditing(true)
    }
}
