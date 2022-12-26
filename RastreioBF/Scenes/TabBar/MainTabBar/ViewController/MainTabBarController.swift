//
//  MainTabBarController.swift
//  RastreioBF
//
//  Created by Jessica Bigal on 09/09/22.
//

import UIKit

class MainTabBarController: UITabBarController{

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTabBarController()
        setUpNavigationBar()
    }
    
    private func setUpTabBarController() {
        let homeViewController = UINavigationController(rootViewController: TrackingViewController())
        let warningViewController = UINavigationController(rootViewController: WarningViewController())
        let menuViewController = UINavigationController(rootViewController: MenuScreenVC())
        
        self.setViewControllers([homeViewController, warningViewController, menuViewController], animated: true)

        self.tabBar.selectedImageTintColor = UIColor(named: LC.mainPurpleColor.text)
        self.tabBar.backgroundColor = .white
        self.tabBar.alpha = 0.9
        self.tabBar.isTranslucent = false

        guard let items = tabBar.items else {return}
        
        items[0].title = LC.homeTitleTab.text
        items[0].image = UIImage(systemName: LC.homeIcon.text)
        
        items[1].title = LC.trackingTitleTab.text
        items[1].image = UIImage(systemName: LC.trackingIcon.text)
        
        items[2].title = LC.menuTitleTab.text
        items[2].image = UIImage(systemName: LC.menuIcon.text)
    }
    
    private func setUpNavigationBar(){
        navigationController?.navigationBar.barStyle = .default
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.red]
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.red]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
    }
}

extension UINavigationBar {
    func customNavigationBar() {
        self.prefersLargeTitles = false
        self.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.systemPink]
        self.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.systemPink]
    }
}
