//
//  Coordinator.swift
//  RastreioBF
//
//  Created by Jessica Bigal on 22/11/22.
//

import Foundation
import UIKit

enum Event {
    case buttonTapped
    case goBackTapped
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
