//
//  Coordinator.swift
//  RastreioBF
//
//  Created by Jessica Bigal on 22/11/22.
//

import Foundation
import UIKit

enum Event {
    case signUp
    case goBackTapped
    case onboarding
    case login
    case resetPassword
    case mainTabbar
    case menu
    case tracking
    case warning
    case done
    case pendencies
}

protocol Coordinator {
    var navigationController: UINavigationController? { get set }
    var children: [Coordinator]? { get set }
    
    func eventOcurred(with type: Event)
    func start()
}

protocol Coordinating {
    var coordinator: Coordinator? { get set }
}
