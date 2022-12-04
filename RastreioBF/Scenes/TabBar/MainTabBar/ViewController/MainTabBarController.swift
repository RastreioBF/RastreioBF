//
//  MainTabBarController.swift
//  RastreioBF
//
//  Created by Jessica Bigal on 09/09/22.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTabBarController()
        setUpNavigationBar()
    }
    
    
    private func setUpTabBarController() {
        
        //Adiciona as telas na TabBarController
        let homeViewController = UINavigationController(rootViewController: TrackingViewController())
        let warningViewController = UINavigationController(rootViewController: WarningViewController())
        let doneViewController = UINavigationController(rootViewController: DoneViewController())
        let pendenciesViewController = UINavigationController(rootViewController: PendenciesViewController())
        let menuViewController = UINavigationController(rootViewController: MenuScreenVC())
        
        //Array com a ordem das telas
        self.setViewControllers([homeViewController, warningViewController, doneViewController, pendenciesViewController, menuViewController], animated: true)
        
        //Configura a visualizacao da tabBar
        self.tabBar.selectedImageTintColor = UIColor(named: "mainPurpleColor")
        self.tabBar.backgroundColor = .white //cor de fundo
        self.tabBar.alpha = 0.9
        self.tabBar.isTranslucent = false
        
        //Adiciona icone e atribui titulo de acordo com a posicao no array
        guard let items = tabBar.items else {return}
        
        items[0].title = "Home"
        items[0].image = UIImage(named: "home")
        
        items[1].title = "Avisos"
        items[1].image = UIImage(named: "avisos")
        
        items[2].title = "Finalizados"
        items[2].image = UIImage(named: "finalizados")
        
        items[3].title = "Pendências"
        items[3].image = UIImage(named: "pendencias")
        
        items[4].title = "Menu"
        items[4].image = UIImage(named: "menu")
    }
    
    private func setUpNavigationBar(){
//        UINavigationBar.appearance().barStyle = .default
//        UINavigationBar.appearance().tintColor = UIColor(named: "mainPurpleColor")
        navigationController?.navigationBar.barStyle = .default
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.red]
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.red]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
    }
}

extension UINavigationBar {
    func customNavigationBar() {
        // color for button images, indicators and etc.
//        self.tintColor = UIColor.red

        // color for background of navigation bar
        // but if you use larget titles, then in viewDidLoad must write
        // navigationController?.view.backgroundColor = // your color
//        self.barTintColor = .white
//        self.isTranslucent = false

        // for larget titles
        self.prefersLargeTitles = false

        // color for large title label
        self.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.systemPink]

        // color for standard title label
        self.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.systemPink]

        // remove bottom line/shadow
//        self.setBackgroundImage(UIImage(), for: .default)
//        self.shadowImage = UIImage()
    }
}
