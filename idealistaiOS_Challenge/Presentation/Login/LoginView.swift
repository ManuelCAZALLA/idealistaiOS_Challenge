//
//  LoginView.swift
//  idealistaiOS_Challenge
//
//  Created by Manuel Cazalla Colmenero on 14/5/25.
//

import SwiftUI

struct LoginView: View {
    // Estados para los campos
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var rememberMe: Bool = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                
                Spacer()
                
                VStack(spacing: 16) {
                   
                    TextField("Email", text: $email)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(8)
                        .foregroundColor(.black)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color(hex: "#f8be77"), lineWidth: 1)
                        )
                    
                SecureField("Contraseña", text: $password)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(8)
                        .foregroundColor(.black)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color(hex: "#f8be77"), lineWidth: 1)
                        )
                    
                   Toggle(isOn: $rememberMe) {
                        Text("Recordarme")
                            .foregroundColor(Color(hex: "#f8be77"))
                    }
                    .padding(.horizontal)
                    
                    Button(action: {
                       // Accion de login
                    }) {
                        Text("Iniciar sesión")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.black)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                    .padding(.top, 10)
                }
                .padding(.horizontal, 24)
                
                Spacer()
            }
            .background(Color(hex: "#ffe600").ignoresSafeArea()) // Fondo estilo idealista
        }
    }
}
#Preview {
    LoginView()
}
