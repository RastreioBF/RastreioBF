// teste
//  MenuScreenViewController.swift
//  RastreioBF
//
//  Created by Jessica Bigal on 09/09/22.
//

import UIKit


class MenuScreenVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private var menuVM = MenuViewModel()
    private var alert: Alert?
    
    private let tablewView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(MenuTableViewCell.self, forCellReuseIdentifier: MenuTableViewCell.identifier)
        table.register(SwitchTableViewCell.self, forCellReuseIdentifier: SwitchTableViewCell.identifier)
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        alert = Alert(controller: self)
        configSections()
        title = "Menu"
        view.addSubview(tablewView)
        tablewView.delegate = self
        tablewView.dataSource = self
        tablewView.frame = view.bounds
        navigationController?.navigationBar.isHidden = true
    }
    
    func configSections(){
        menuVM.addSectionToArray(section: Section(title: "Notificações", options:
                                                    [
                                                        .switchCell(model: SettingsSwitchOption(title: "Notificações", icon: UIImage(systemName: "house"), iconBackgroundColor: .systemOrange, handler: {
                                                        }, isOn: true)),
                                                    ]))
        menuVM.addSectionToArray(section: Section(title: "Privacidade", options:
                                                    [
                                                        .staticCell(model: SettingsOption(title: "Solicitar Meus Dados", icon: UIImage(systemName: "person.text.rectangle"), iconBackgroundColor: .systemGreen){
                                                            let myData = RequestUserDataViewController()
                                                            self.navigationController?.pushViewController(myData, animated: true)
                                                        }),
                                                        .staticCell(model: SettingsOption(title: "Politica de Privacidade", icon: UIImage(systemName: "airplane"), iconBackgroundColor: .systemPurple) {
                                                            let privacyPolicy = PrivacyPoliciesViewController()
                                                            self.navigationController?.pushViewController(privacyPolicy, animated: true)
                                                        }),
                                                        .staticCell(model: SettingsOption(title: "Remover meus Dados", icon: UIImage(systemName: "person.crop.circle.badge.xmark"), iconBackgroundColor: .systemCyan){
                                                            let removeUser = RemoveUserViewController()
                                                            self.navigationController?.pushViewController(removeUser, animated: true)
                                                        }),
                                                    ]))
        menuVM.addSectionToArray(section: Section(title: "Sair", options:
                                                    [
                                                        .staticCell(model : SettingsOption(title: "Logout", icon: UIImage(systemName: "person.badge.minus"), iconBackgroundColor: .systemRed){
                                                            let alert: Alert = Alert(controller: self)
                                                            alert.userAlertLogout()
                                                        })
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
        case .switchCell(let model):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SwitchTableViewCell.identifier, for: indexPath ) as? SwitchTableViewCell else {
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
        case .switchCell(let model):
            model.handler()
        }
    }
}
