//
//  EmailConfirmationViewController.swift
//  RastreioBF
//
//  Created by Jessica Bigal on 09/09/22.
//

import UIKit
import FirebaseAuth

class EmailConfirmationViewController: UIViewController {
    
    var auth:Auth?
    var emailConfirmationScreen:EmailConfirmationScreen?
    var alert:Alert?
    var viewModel: EmailConfirmationViewModel = EmailConfirmationViewModel()
    
    override func loadView() {
        self.emailConfirmationScreen = EmailConfirmationScreen()
        view = self.emailConfirmationScreen
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        emailConfirmationScreen?.delegate = self
        emailConfirmationScreen?.emailErrorLabel.isHidden = true
        auth = Auth.auth()
        alert = Alert(controller: self)
        emailConfirmationScreen?.emailTextField.delegate = self
        setupKeyboardHiding()
    }
    
    init(viewModel: EmailConfirmationViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupKeyboardHiding() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func resetPasswordAuth(email: String, onSuccess: @escaping() -> Void, onError: @escaping(_ errorMessage:String) -> Void) {
        Auth.auth().sendPasswordReset(withEmail: email) { (error) in
            if error == nil {
                onSuccess()
            } else {
                self.alert?.getAlert(titulo: LC.atentionTitle.text, mensagem: LC.errorOccurred.text)
            }
        }
    }
}

//MARK: Extensions

extension EmailConfirmationViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        default:
            textField.resignFirstResponder()
        }
        return false
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

extension EmailConfirmationViewController {
    @objc func keyboardWillShow(sender: NSNotification) {
        guard let userInfo = sender.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue,
              let currentTextField = UIResponder.currentFirst() as? UITextField else { return }
        
        let keyboardTopY = keyboardFrame.cgRectValue.origin.y
        let convertedTextFieldFrame = view.convert(currentTextField.frame, from: currentTextField.superview)
        let textFieldBottomY = convertedTextFieldFrame.origin.y + convertedTextFieldFrame.size.height
        
        if textFieldBottomY > keyboardTopY {
            let textBoxY = convertedTextFieldFrame.origin.y
            let newFrameY = (textBoxY - keyboardTopY / 1.23) * -1
            view.frame.origin.y = newFrameY
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        view.frame.origin.y = 0
    }
}

extension EmailConfirmationViewController: EmailConfirmationScreenDelegate {
    func actionGoBackTapped() {
        self.navigationController?.popViewController(animated: false)
    }
    
    func actionGoToCodeButtonTapped() {
        guard let email = self.emailConfirmationScreen?.emailTextField.text else {return}
        
        if email.isEmpty {
            self.alert?.getAlert(titulo: LC.atentionTitle.text, mensagem: LC.insertEmailBody.text)
        } else {
            resetPasswordAuth(email: email, onSuccess: {
                self.view.endEditing(true)
                self.alert?.getAlert(titulo: LC.emailSent.text, mensagem: LC.linkSentMesageBody.text, completion: {
                    self.navigationController?.popViewController(animated: true)
                })
            })
            { (errorMessage) in
                self.alert?.getAlert(titulo:  LC.atentionTitle.text, mensagem: LC.verifyAndTryAgain.text)
            }
        }
    }
    
    func didTapEmailTapped() {
        Masks.shared.emailMaskVerify(text: self.emailConfirmationScreen?.emailTextField.text ?? "", label: self.emailConfirmationScreen?.emailErrorLabel ?? UILabel(), messageEmpty: LC.emptyEmailError.text, messageEmailError: LC.emailFormatError.text)
    }
    
    func actionSignUpButtonTapped() {
        let vc: SignUpViewController = SignUpViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}
