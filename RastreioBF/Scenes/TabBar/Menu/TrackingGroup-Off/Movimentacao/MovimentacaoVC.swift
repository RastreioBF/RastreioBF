//
//  MovimentacaoVC.swift
//  BackFrontProject
//
//  Created by ALYSSON MENEZES on 25/08/22.
//

import UIKit

class MovimentacaoVC: UIViewController {
    var movimentacao = MovimentacaoScreen()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    

    override func loadView() {
        self.movimentacao = MovimentacaoScreen()
        super.viewDidLoad()
        self.view = self.movimentacao
    }
}
