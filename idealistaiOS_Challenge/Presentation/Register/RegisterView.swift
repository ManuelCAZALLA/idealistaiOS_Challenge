//
//  RegisterView.swift
//  idealistaiOS_Challenge
//
//  Created by Manuel Cazalla Colmenero on 18/5/25.
//

import SwiftUI

struct RegisterView: View {
    @State private var nombre: String = ""
    @State private var apellidos: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var mensaje: String = ""

    var body: some View {
        VStack(spacing: 20) {
            Text("Registro")
                .font(.largeTitle)
                .bold()
            
            TextField("Nombre", text: $nombre)
                .textFieldStyle(.roundedBorder)
            TextField("Apellidos", text: $apellidos)
                .textFieldStyle(.roundedBorder)
            TextField("Email", text: $email)
                .textFieldStyle(.roundedBorder)
                .keyboardType(.emailAddress)
            SecureField("Contraseña", text: $password)
                .textFieldStyle(.roundedBorder)

            Button("Registrar") {
                let user = User(nombre: nombre, apellidos: apellidos, email: email, password: password)
                JSONStorage.shared.saveUser(user)
                mensaje = "Usuario registrado correctamente ✅"
                            }
            .padding()
            .background(Color.green)
            .foregroundColor(.white)
            .cornerRadius(8)

            if !mensaje.isEmpty {
                Text(mensaje)
                    .foregroundColor(.green)
            }

            Spacer()
        }
        .padding()
        .background(Color(hex: "#ffe600").ignoresSafeArea())
    }
}


#Preview {
    RegisterView()
}
