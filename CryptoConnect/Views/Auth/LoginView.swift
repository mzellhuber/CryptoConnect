//
//  LoginView.swift
//  CryptoConnect
//
//  Created by Melissa Zellhuber on 04/09/23.
//

import SwiftUI

struct LoginView: View {
    @StateObject private var viewModel = AuthViewModel()
    
    @State private var usernameOrEmail = ""
    @State private var password = ""
    
    @Binding var isRegisterViewActive: Bool
    
    var body: some View {
        VStack(spacing: 20) {
            TextField("Username or Email", text: $usernameOrEmail, prompt: Text("Username or Email").foregroundColor(.gray))
                .padding()
                .background(ColorPalette.secondaryBackground)
                .cornerRadius(8)
                .padding(.horizontal)
            
            SecureField("Password", text: $password, prompt: Text("Password").foregroundColor(.gray))
                .padding()
                .background(ColorPalette.secondaryBackground)
                .cornerRadius(8)
                .padding(.horizontal)
            
            CustomButton(title: "Login", action: {
                // Handle login action
            })
            .padding(.horizontal)
            
            Button(action: {
                isRegisterViewActive.toggle()
            }) {
                Text("Don't have an account? Register")
                    .foregroundColor(ColorPalette.navigationText)
                    .underline()
            }
            .padding(.top, 10)
            
            Spacer()
        }
        .padding(.top, 100)
        .background(ColorPalette.primaryBackground)
        .edgesIgnoringSafeArea(.all)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Login")
                    .foregroundColor(ColorPalette.navigationText)
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(isRegisterViewActive: .constant(false))
    }
}
