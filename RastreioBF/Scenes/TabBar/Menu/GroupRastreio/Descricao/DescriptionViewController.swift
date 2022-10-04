//
//  RastreioVC.swift
//  BackFrontProject
//
//  Created by ALYSSON MENEZES on 24/08/22.
//

import UIKit

class DescriptionViewController: UIViewController {
    
    var rastreioScreen : DescriptionView?

    override func loadView() {
        self.rastreioScreen = DescriptionView()
        self.view = self.rastreioScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
}

