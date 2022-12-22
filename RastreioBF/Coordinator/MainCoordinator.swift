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
    var emailConfirmationViewModel: EmailConfirmationViewModel = EmailConfirmationViewModel()
    
    func eventOcurred(with type: Event) {
        switch type {
        case .signUp:
            var vc: UIViewController & Coordinating = SignUpViewController()
            vc.coordinator = self
            navigationController?.pushViewController(vc, animated: true)
            children?.removeAll()
        case .goBackTapped:
            navigationController?.popViewController(animated: true)
        case .onboarding:
            var vc: UIViewController & Coordinating = DemoViewController()
            vc.coordinator = self
            navigationController?.pushViewController(vc, animated: true)
            children?.removeAll()
        case .login:
            var vc: UIViewController & Coordinating = LoginViewController()
            vc.coordinator = self
            navigationController?.pushViewController(vc, animated: true)
            children?.removeAll()
        case .resetPassword:
            var vc: UIViewController & Coordinating = EmailConfirmationViewController(viewModel: emailConfirmationViewModel)
            vc.coordinator = self
            navigationController?.pushViewController(vc, animated: true)
        case .mainTabbar:
            var vc: UIViewController & Coordinating = MainTabBarController()
            vc.coordinator = self
            navigationController?.pushViewController(vc, animated: true)
            children?.removeAll()
        case .menu:
            var vc: UIViewController & Coordinating = MenuScreenVC()
            vc.coordinator = self
            navigationController?.pushViewController(vc, animated: true)
            children?.removeAll()
        case .tracking:
            var vc: UIViewController & Coordinating = DoneViewController()
            vc.coordinator = self
            navigationController?.pushViewController(vc, animated: true)
            children?.removeAll()
        case .warning:
            var vc: UIViewController & Coordinating = DoneViewController()
            vc.coordinator = self
            navigationController?.pushViewController(vc, animated: true)
            children?.removeAll()
        case .done:
            var vc: UIViewController & Coordinating = DoneViewController()
            vc.coordinator = self
            navigationController?.pushViewController(vc, animated: true)
            children?.removeAll()
        case .pendencies:
            var vc: UIViewController & Coordinating = PendenciesViewController()
            vc.coordinator = self
            navigationController?.pushViewController(vc, animated: true)
            children?.removeAll()
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
