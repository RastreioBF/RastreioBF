//
//  MainCoordinator.swift
//  RastreioBF
//
//  Created by Jessica Bigal on 22/11/22.
//

import Foundation
import UIKit

class MainCoordinator: Coordinator {
    var navigationController: UINavigationController?
    var children: [Coordinator]? = nil
    
    func eventOcurred(with type: Event) {
        switch type {
        case .buttonTapped:
            var vc: UIViewController & Coordinating = SignUpViewController()
            vc.coordinator = self
            navigationController?.pushViewController(vc, animated: true)
            
        case .goBackTapped:
            navigationController?.popViewController(animated: true)
        }
    }
    
    func start() {
        var vc: UIViewController & Coordinating = LoginViewController()
        vc.coordinator = self
        navigationController?.setViewControllers([vc], animated: false)
    }
}

extension MainCoordinator: EmailConfirmationCoordinatorProtocol {
    func actionGoToCodeButton() {
        //
        
    }
    
    func didTapEmail() {
        //
    }
    
    func actionGoBack() {
        var vc: UIViewController & Coordinating = LoginViewController()
        vc.coordinator = self
        navigationController?.setViewControllers([vc],
                                                 animated: false)
    }
    
    func actionSignUpButton() {
        var vc: UIViewController & Coordinating = SignUpViewController()
        vc.coordinator = self
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
