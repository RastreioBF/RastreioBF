//
//  ModelService.swift
//  RastreioBF
//
//  Created by Jessica Bigal on 17/11/22.
//

import Foundation
//
//struct Package: Codable {
//    let objetos: [Objeto]
//}
//
//struct Objeto: Codable {
//    let codObjeto: String?
//    let evento: [Evento]
//}
//
//struct Evento: Codable {
//    let unidade: Unidade
//    let descricao: String?
//    let urlIcone: String?
//    let dtHrCriado: String?
//}
//
//struct Unidade: Codable {
//    let endereco: UnidadeEndereco
//    let tipo: String?
//}
//
//struct UnidadeEndereco: Codable {
//    let cidade: String?
//    let uf: String?
//    let bairro: String?
//    let logradouro: String?
//}

// MARK: - Header
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
