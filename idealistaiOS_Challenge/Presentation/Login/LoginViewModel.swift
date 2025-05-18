//
//  LoginViewModel.swift
//  idealistaiOS_Challenge
//
//  Created by Manuel Cazalla Colmenero on 14/5/25.
//

import Foundation
import KeychainSwift

class LoginViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var responseMessage = ""
    @Published var isLoggedIn = false
    @Published var user: User?

    private let keychain = KeychainSwift()

    // Verificar si hay un token guardado al iniciar la app
    func checkSession() {
        if let savedToken = keychain.get("authToken"), !savedToken.isEmpty {
            self.isLoggedIn = true
            self.responseMessage = "Sesión iniciada automáticamente"
        } else {
            self.isLoggedIn = false
        }
    }

    // Simulación de login desde JSON local
    func login() {
        guard let path = Bundle.main.path(forResource: "MockUser", ofType: "json"),
              let data = try? Data(contentsOf: URL(fileURLWithPath: path)) else {
            self.responseMessage = "No se pudo cargar el json de usuarios"
            self.isLoggedIn = false
            return
        }

        do {
            let users = try JSONDecoder().decode([User].self, from: data)
            if let matchedUser = users.first(where: { $0.email == email && $0.password == password }) {
                self.user = matchedUser
                self.isLoggedIn = true
                self.responseMessage = "Login exitoso"

               
                let fakeToken = "simulated_token_\(matchedUser.id)"
                keychain.set(fakeToken, forKey: "authToken")
            } else {
                self.responseMessage = "Credenciales inválidas"
                self.isLoggedIn = false
            }
        } catch {
            self.responseMessage = "Error al procesar el archivo JSON"
            self.isLoggedIn = false
        }
    }

    func logout() {
        keychain.delete("authToken")
        self.isLoggedIn = false
        self.user = nil
        self.responseMessage = "Sesión cerrada"
    }
}
