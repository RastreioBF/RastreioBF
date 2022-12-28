//
//  MenuResources.swift
//  RastreioBF
//
//  Created by Anderson Sales on 26/12/22.
//

import UIKit

struct Section {
    let title: String
    let options: [SettingsOptionsType]
}

enum SettingsOptionsType {
    case staticCell(model: SettingsOption)
}

struct SettingsOption {
    let title: String
    let icon: UIImage?
    let iconBackgroundColor: UIColor
    let handler: (() -> Void)
}
