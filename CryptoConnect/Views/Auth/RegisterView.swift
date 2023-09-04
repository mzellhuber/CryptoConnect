//
//  RegisterView.swift
//  CryptoConnect
//
//  Created by Melissa Zellhuber on 04/09/23.
//

import SwiftUI

struct RegisterView: View {
    @StateObject private var viewModel = AuthViewModel()
    
    @State private var username = ""
    @State private var email = ""
    @State private var password = ""
    @State private var mnemonics = ""
    @State private var privateKey = ""
    @State private var selectedTab = 0
    
    @Binding var isRegisterViewActive: Bool
    
    var body: some View {
        VStack(spacing: 20) {
            TextField("Username", text: $username, prompt: Text("Username").foregroundColor(.gray))
                .padding()
                .background(ColorPalette.secondaryBackground)
                .cornerRadius(8)
                .padding(.horizontal)
            
            TextField("Email", text: $email, prompt: Text("Email").foregroundColor(.gray))
                .padding()
                .background(ColorPalette.secondaryBackground)
                .cornerRadius(8)
                .padding(.horizontal)
            
            SecureField("Password", text: $password, prompt: Text("Password").foregroundColor(.gray))
                .padding()
                .background(ColorPalette.secondaryBackground)
                .cornerRadius(8)
                .padding(.horizontal)
            
            Picker("", selection: $selectedTab) {
                Text("Create Wallet").tag(0)
                Text("Import Wallet").tag(1)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.horizontal)
            
            if selectedTab == 0 {
                TextField("Mnemonics", text: $mnemonics, prompt: Text("Mnemonics").foregroundColor(.gray))
                    .padding()
                    .background(ColorPalette.secondaryBackground)
                    .cornerRadius(8)
                    .padding(.horizontal)
            } else {
                TextField("Private Key", text: $privateKey, prompt: Text("Private Key").foregroundColor(.gray))
                    .padding()
                    .background(ColorPalette.secondaryBackground)
                    .cornerRadius(8)
                    .padding(.horizontal)
            }
            
            CustomButton(title: "Register", action: {
                // Handle register action
            })
            .padding(.horizontal)
            
            Button(action: {
                isRegisterViewActive.toggle()
            }) {
                Text("Already have an account? Login")
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
                Text("Register")
                    .foregroundColor(ColorPalette.navigationText)
            }
        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView(isRegisterViewActive: .constant(true))
    }
}
