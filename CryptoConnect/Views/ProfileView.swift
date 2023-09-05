//
//  ProfileView.swift
//  CryptoConnect
//
//  Created by Melissa Zellhuber on 04/09/23.
//

import SwiftUI

struct ProfileView: View {
    @ObservedObject var viewModel: ProfileViewModel

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                viewModel.profilePicture
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 4))
                    .shadow(radius: 10)
                
                Text(viewModel.username)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Text(viewModel.email)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                // Add more user profile details here
                
                Spacer()
            }
            .padding()
            .background(ColorPalette.primaryBackground)
            .edgesIgnoringSafeArea(.all)
            .navigationBarTitle("Profile", displayMode: .inline)
        }
        .onAppear {
            viewModel.fetchUserProfile()
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(viewModel: ProfileViewModel())
    }
}
