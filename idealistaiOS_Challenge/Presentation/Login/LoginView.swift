//
//  LoginView.swift
//  idealistaiOS_Challenge
//
//  Created by Manuel Cazalla Colmenero on 14/5/25.
//

import SwiftUI

struct LoginView: View {
    
    @ObservedObject var viewModel = LoginViewModel()
    @State private var rememberMe: Bool = false

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Spacer()
                
                VStack(spacing: 16) {
                    
                    Text("IN")
                   .font(.custom("Chalkduster", size: 56))
                    
                    Spacer()

                   TextField("Email", text: $viewModel.email)
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
                    
                    SecureField("Contraseña", text: $viewModel.password)
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
                            .foregroundColor(Color.blue)
                    }
                    .padding(.horizontal)
                    
                    Button(action: {
                        viewModel.login()
                    }) {
                        Text("Iniciar sesión")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.black)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                    NavigationLink(destination: RegisterView()) {
                        Text("¿No tienes cuenta? Regístrate")
                            .foregroundColor(.blue)
                            .font(.subheadline)
                    }
                    .padding(.top, 10)

                    Spacer()
                    
                    // Mostrar mensaje de respuesta
                    if !viewModel.responseMessage.isEmpty {
                        Text(viewModel.responseMessage)
                            .foregroundColor(viewModel.isLoggedIn ? .green : .red)
                            .font(.subheadline)
                            .padding(.top, 10)
                    }
                }
                .padding(.horizontal, 24)
                
                Spacer()
                
                if viewModel.isLoggedIn {
                    NavigationLink(
                        destination: MainViewControllerRepresentable(),
                        isActive: $viewModel.isLoggedIn
                    ) {
                        EmptyView()
                    }
                }
            }
            .background(Color(hex: "#ffe600").ignoresSafeArea())
        }
    }
}

#Preview {
    LoginView()
}
