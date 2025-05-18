//
//  UserModel.swift
//  idealistaiOS_Challenge
//
//  Created by Manuel Cazalla Colmenero on 17/5/25.
//

import Foundation

struct User: Codable, Identifiable {
    let id: UUID
    let nombre: String
    let apellidos: String
    let email: String
    let password: String

    init(id: UUID = UUID(), nombre: String, apellidos: String, email: String, password: String) {
        self.id = id
        self.nombre = nombre
        self.apellidos = apellidos
        self.email = email
        self.password = password
    }
}
