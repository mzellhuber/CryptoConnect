//
//  MainTabView.swift
//  CryptoConnect
//
//  Created by Melissa Zellhuber on 05/09/23.
//

import SwiftUI

struct MainTabView: View {
    @StateObject private var web3Manager = Web3Manager()

    init() {
        UITabBar.appearance().unselectedItemTintColor = .systemGray
    }

    var body: some View {
        TabView {
            HomeView(viewModel: HomeViewModel())
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
            
            CreatePostView(viewModel: CreatePostViewModel())
                .tabItem {
                    Image(systemName: "square.and.pencil")
                    Text("Create Post")
                }
            
            ProfileView(viewModel: ProfileViewModel())
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Profile")
                }
        }
        .onAppear(perform: onAppear)
    }
    
    func onAppear() {
        Task {
            await web3Manager.setProviderAsync()
        }
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
