//
//  JsonStorage.swift
//  idealistaiOS_Challenge
//
//  Created by Manuel Cazalla Colmenero on 18/5/25.
//

import Foundation

class JSONStorage {
    static let shared = JSONStorage()
    
    private let fileName = "MockUser.json"
    
    private var fileURL: URL {
        let manager = FileManager.default
        let urls = manager.urls(for: .documentDirectory, in: .userDomainMask)
        return urls[0].appendingPathComponent(fileName)
    }
    
    func saveUser(_ user: User) {
        var users = loadUsers()
        users.append(user)
        
        do {
            let data = try JSONEncoder().encode(users)
            try data.write(to: fileURL)
            print("✅ Usuarios guardados correctamente en: \(fileURL.path)")
        } catch {
            print("❌ Error guardando usuarios: \(error.localizedDescription)")
        }
    }

    func loadUsers() -> [User] {
        do {
            let data = try Data(contentsOf: fileURL)
            let users = try JSONDecoder().decode([User].self, from: data)
            print("✅ Usuarios cargados: \(users.count)")
            return users
        } catch {
            print("⚠️ No se pudo cargar usuarios o archivo no existe. Error: \(error.localizedDescription)")
            return []
        }
    }

}

