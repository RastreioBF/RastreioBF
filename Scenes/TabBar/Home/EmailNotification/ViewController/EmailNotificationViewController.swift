//
//  EmailNotificationViewController.swift
//  ViewCodeProject
//
//  Created by Anderson Sales on 11/09/22.
//

import UIKit

class EmailNotificationViewController: UIViewController {
    
    var emailNotificationScreen: EmailNotificationScreen?
    var alert: Alert?
    
    override func loadView() {
        self.emailNotificationScreen = EmailNotificationScreen()
        self.view = self.emailNotificationScreen
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.emailNotificationScreen?.configTextFieldDelegate(delegate: self)
        self.emailNotificationScreen?.delegate(delegate: self)
        self.alert = Alert(controller: self)
        self.emailNotificationScreen?.delegate = self
        self.emailNotificationScreen?.emailErrorLabel.isHidden = true
        self.setupKeyboardHiding()

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
        self.emailNotificationScreen?.validateTextFields()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension EmailNotificationViewController: EmailNotificationScreenProtocol{
    
    func didTapEmail() {
        let text =  self.emailNotificationScreen?.emailTextField.text ?? ""
        let label =  self.emailNotificationScreen?.emailErrorLabel
        
        if text.isEmpty {
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
        self.alert?.getAlert(titulo: "Tudo certo", mensagem: "Email cadastrado com sucesso!", completion: actionBackButton)
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
            let newFrameY = (textBoxY - keyboardTopY / 1.3) * -1
            view.frame.origin.y = newFrameY
        }

        print("foo - userInfo: \(userInfo)")
        print("foo - keyboardFrame: \(keyboardFrame)")
        print("foo - currentTextField: \(currentTextField)")
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
          view.frame.origin.y = 0
      }
}
