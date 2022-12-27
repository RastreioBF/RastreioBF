//
//  MenuViewModel.swift
//  RastreioBF
//
//  Created by Anderson Sales on 26/12/22.
//

import Foundation

class MenuViewModel {
    
    private static var models = [Section]()
    
    func addSectionToArray(section: Section) {
        MenuViewModel.models.append(section)
    }
    
    var numberOfSections: Int {
        return MenuViewModel.models.count
    }
    
    func loadCurrentOption(indexPath: IndexPath) -> SettingsOptionsType {
        return MenuViewModel.models[indexPath.section].options[indexPath.row]
    }
    
    func loadCurrentSection(index: Int) -> Section {
        return MenuViewModel.models[index]
    }
    
    func getNumberOfRowsInSection (index: Int) -> Int {
        return MenuViewModel.models[index].options.count
    }
}
