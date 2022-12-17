//
//  RastreioAPIViewModel.swift
//  RastreioBF
//
//  Created by Jessica Bigal on 13/12/22.
//

import Foundation

struct Package: Codable {
    let codigo, servico, host: String?
    let quantidade: Int?
    let eventos: [Eventos]?
}

// MARK: - Eventos
struct Eventos: Codable {
    let data, hora: String?
    let local: String?
    let status: String?
    let subStatus: [String]?
}
