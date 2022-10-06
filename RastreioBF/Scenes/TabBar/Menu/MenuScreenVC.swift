//
//  MenuScreenViewController.swift
//  RastreioBF
//
//  Created by Jessica Bigal on 09/09/22.
//

import UIKit

struct Section {
    let title: String
    let options : [SettingsOptionsType]
}

enum SettingsOptionsType {
    case staticCell(model : SettingsOption)
    case switchCell(model : SettingsSwitchOption)
}

struct SettingsSwitchOption {
    let title : String
    let icon : UIImage?
    let iconBackgroundColor: UIColor
    let handler: (() -> Void)
    var  isOn: Bool
}

struct SettingsOption {
    let title : String
    let icon : UIImage?
    let iconBackgroundColor: UIColor
    let handler: (() -> Void)
}

class MenuScreenVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    private let tablewView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(SettingsTableViewCell.self, forCellReuseIdentifier: SettingsTableViewCell.identifier)
        table.register(SwitchTableViewCell.self, forCellReuseIdentifier: SwitchTableViewCell.identifier)
        return table
    }()
    
    var models = [Section]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        title = "Settings"
        view.addSubview(tablewView)
        tablewView.delegate = self
        tablewView.dataSource = self
        tablewView.frame = view.bounds
        self.navigationController?.navigationBar.isHidden = true
    }
    
    // icones e descricao
    func configure(){
        // grupo 1
        models.append(Section(title: "Notificações", options: [
            .switchCell(model : SettingsSwitchOption(title: "Notificações", icon: UIImage(systemName: "house"), iconBackgroundColor: .systemOrange, handler: {
                // colocar acao aqui
                
            }, isOn: true)),
            
        ]))
        
        // grupo 1 ... 
        //    models.append(Section(title: "Rastreio", options: [
        //
        //        .staticCell(model : SettingsOption(title: "Rastreiamento", icon: UIImage(systemName: "airplane"), iconBackgroundColor: .systemGreen){
        //            let vc = DescricaoVC()
        //            self.navigationController?.pushViewController(vc, animated: true )
        //        }),
        //        .staticCell(model : SettingsOption(title: "Cadastro", icon: UIImage(systemName: "cloud"), iconBackgroundColor: .systemCyan){
        //            let cadastro = CadastroVC()
        //            self.navigationController?.pushViewController(cadastro, animated: true)
        //        }),
        //        .staticCell(model : SettingsOption(title: "Movimentação", icon: UIImage(systemName: "house"), iconBackgroundColor: .systemPurple){
        //            let movimentacao = MovimentacaoVC()
        //            self.navigationController?.pushViewController(movimentacao, animated: true)
        //        }),
        //
        //
        //    ]))
        // grupo 4
        models.append(Section(title: "Privacidade", options: [
            
            .staticCell(model : SettingsOption(title: "Solicitar Meus Dados", icon: UIImage(systemName: "person.text.rectangle"), iconBackgroundColor: .systemGreen){
                let meusDados = RequestUserDataViewController()
                self.navigationController?.pushViewController(meusDados, animated: true)
            }),
            .staticCell(model : SettingsOption(title: "Politica de Privacidade", icon: UIImage(systemName: "airplane"), iconBackgroundColor: .systemPurple){
                let privacyPolicy = PrivacyPoliciesViewController()
                self.navigationController?.pushViewController(privacyPolicy, animated: true)
            }),
            .staticCell(model : SettingsOption(title: "Remover meus Dados", icon: UIImage(systemName: "person.crop.circle.badge.xmark"), iconBackgroundColor: .systemCyan){
                
                let removeUser = RemoveUserViewController()
                self.navigationController?.pushViewController(removeUser, animated: true)
            }),
        ]))
        
        // grupo 4
        models.append(Section(title: "Sair", options: [
            
            .staticCell(model : SettingsOption(title: "Logout", icon: UIImage(systemName: "person.badge.minus"), iconBackgroundColor: .systemRed){
                // let meusDados = MeusDadosVC() referenciar a tela logout
                //    self.navigationController?.pushViewController(meusDados, animated: true) mudar de tela
                let alert : Alert = Alert(controller: self)
                alert.userAlertLogout()
            }),
            
        ]))
        
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let section = models[section]
        return section.title
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models[section].options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[ indexPath.section].options[ indexPath.row]
        
        switch model.self {
        case .staticCell(let model):
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: SettingsTableViewCell.identifier,
                for: indexPath
            ) as? SettingsTableViewCell else {
                return UITableViewCell()
            }
            cell.configure(width: model)
            return cell
        case .switchCell(let model):
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: SwitchTableViewCell.identifier,
                for: indexPath
            ) as? SwitchTableViewCell else {
                return UITableViewCell()
            }
            cell.configure(width: model)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let type = models[ indexPath.section].options[ indexPath.row]
        switch type.self {
        case .staticCell(let model):
            model.handler()
        case .switchCell(let model):
            model.handler()
            
        }
    }
}
