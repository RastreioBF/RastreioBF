//
//  RastreioVC.swift
//  BackFrontProject
//
//  Created by ALYSSON MENEZES on 24/08/22.
//

import UIKit

class DescricaoVC: UIViewController {
    
    var rastreioScreen : DescricaoScreen?

    override func loadView() {
        self.rastreioScreen = DescricaoScreen()
        self.view = self.rastreioScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
}

