//
//  AuthParentView.swift
//  CryptoConnect
//
//  Created by Melissa Zellhuber on 04/09/23.
//

import SwiftUI

struct AuthParentView: View {
    @State private var isRegisterViewActive = false
    
    var body: some View {
        NavigationView {
            if isRegisterViewActive {
                RegisterView(isRegisterViewActive: $isRegisterViewActive)
            } else {
                LoginView(isRegisterViewActive: $isRegisterViewActive)
            }
        }
    }
}

#Preview {
    AuthParentView()
}
