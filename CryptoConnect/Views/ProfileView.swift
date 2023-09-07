//
//  ProfileView.swift
//  CryptoConnect
//
//  Created by Melissa Zellhuber on 04/09/23.
//

import SwiftUI

struct ProfileView: View {
    @ObservedObject var viewModel: ProfileViewModel
    @StateObject private var web3Manager = Web3Manager()

    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                VStack(spacing: 20) {
                    viewModel.profilePicture
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.white, lineWidth: 4))
                        .shadow(radius: 10)
                        .background(Color.gray.opacity(0.2))
                    
                    Text(viewModel.username)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(ColorPalette.primaryText)
                    
                    Text(viewModel.email)
                        .font(.subheadline)
                        .foregroundColor(ColorPalette.secondaryText)
                    
                    if let walletAddress = viewModel.walletAddress {
                        TipButton(walletAddress: walletAddress, web3Manager: web3Manager)
                            .padding()
                            .background(LinearGradient(gradient: Gradient(colors: [Color.purple, Color.blue]), startPoint: .top, endPoint: .bottom))
                            .cornerRadius(10)
                    }
                    
                    Spacer()
                }
                .frame(width: geometry.size.width)
                .background(ColorPalette.primaryBackground.edgesIgnoringSafeArea(.all))
                .navigationBarTitle("Profile", displayMode: .inline)
            }
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
