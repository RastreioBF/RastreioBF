//
//  EmailConfirmationCoordinator.swift
//  RastreioBF
//
//  Created by Jessica Bigal on 10/11/22.
//

import Foundation
import UIKit

class EmailConfirmationCoordinator: EmailConfirmationCoordinatorProtocol{
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewModel = EmailConfirmationViewModel()
        viewModel.navigationListener = self
        let vc = EmailConfirmationViewController(viewModel: viewModel)
        self.navigationController.pushViewController(vc, animated: true)
    }
    
    func actionGoBack() {
        self.navigationController.dismiss(animated: false)
    }
    
    func actionSignUpButton() {
        let vc: SignUpViewController = SignUpViewController()
        self.navigationController.pushViewController(vc, animated: true)
    }
    
}
