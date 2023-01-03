// teste
//  MenuScreenViewController.swift
//  RastreioBF
//
//  Created by Jessica Bigal on 09/09/22.
//

import UIKit
import FirebaseAuth


class MenuScreenVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private var menuVM = MenuViewModel()
    private var alert: Alert?
    
    private let tablewView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(MenuTableViewCell.self, forCellReuseIdentifier: MenuTableViewCell.identifier)
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        alert = Alert(controller: self)
        configSections()
        title = LC.menuTitle.text
        view.addSubview(tablewView)
        tablewView.delegate = self
        tablewView.dataSource = self
        tablewView.frame = view.bounds
        navigationController?.navigationBar.isHidden = true
    }
    
    func configSections(){
        menuVM.addSectionToArray(section: Section(title: LC.privacyButton.text, options:
                                                    [.staticCell(model: SettingsOption(title: LC.privacyTitle.text, icon: UIImage(systemName: LC.airplaneIcon.text), iconBackgroundColor: .systemPurple) {
            let privacyPolicy = PrivacyPoliciesViewController()
            self.navigationController?.pushViewController(privacyPolicy, animated: true)
        }),
                                                     .staticCell(model: SettingsOption(title: LC.removeDataButton.text, icon: UIImage(systemName: LC.personIcon.text), iconBackgroundColor: .systemCyan){
                                                         self.alert?.getAlertActions(
                                                            titulo:  LC.removeDataTitle.text,
                                                            mensagem: LC.removeDataMessage.text,completion: {
                                                                let user = Auth.auth().currentUser
                                                                user?.delete { error in
                                                                    if error != nil {
                                                                        self.alert?.getAlert(titulo: LC.atentionTitle.text, mensagem: LC.errorOccurred.text)
                                                                    } else {
                                                                        let vc:LoginViewController = LoginViewController()
                                                                        self.navigationController?.pushViewController(vc, animated: false)
                                                                    }
                                                                }
                                                            })
                                                     }),
                                                    ]))
        menuVM.addSectionToArray(section: Section(title: LC.leaveButton.text, options:
                                                    [
                                                        .staticCell(model : SettingsOption(title: LC.logoutButton.text, icon: UIImage(systemName: LC.logoutIcon.text), iconBackgroundColor: .systemRed){
                                                            self.alert?.getAlertActions(
                                                                titulo:  LC.atentionTitle.text,
                                                                mensagem: LC.leaveConfirmation.text,completion: {
                                                                    let firebaseAuth = Auth.auth()
                                                                    do {
                                                                        try firebaseAuth.signOut()
                                                                        let vc:LoginViewController = LoginViewController()
                                                                        self.navigationController?.pushViewController(vc, animated: false)
                                                                    } catch let signOutError as NSError {
                                                                        print("Error signing out: %@", signOutError)
                                                                    }
                                                                })
                                                        }),
                                                    ]))
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let section = menuVM.loadCurrentSection(index: section)
        return section.title
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return menuVM.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuVM.getNumberOfRowsInSection(index: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = menuVM.loadCurrentOption(indexPath: indexPath)
        
        switch model.self {
        case .staticCell(let model):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MenuTableViewCell.identifier, for: indexPath) as? MenuTableViewCell else {
                return UITableViewCell()
            }
            cell.configCell(width: model)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let type = menuVM.loadCurrentOption(indexPath: indexPath)
        switch type.self {
        case .staticCell(let model):
            model.handler()
        }
    }
}
