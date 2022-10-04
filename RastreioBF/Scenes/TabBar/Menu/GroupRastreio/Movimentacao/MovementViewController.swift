//
//  MovimentacaoVC.swift
//  BackFrontProject
//
//  Created by ALYSSON MENEZES on 25/08/22.
//

import UIKit

class MovementViewController: UIViewController {
    var movimentacao = MovementView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    

    override func loadView() {
        self.movimentacao = MovementView()
        super.viewDidLoad()
        self.view = self.movimentacao
    }
}
