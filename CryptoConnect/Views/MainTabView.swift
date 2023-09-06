//
//  MainTabView.swift
//  CryptoConnect
//
//  Created by Melissa Zellhuber on 05/09/23.
//

import SwiftUI

struct MainTabView: View {
    @StateObject private var web3Manager = Web3Manager()

    var body: some View {
        TabView {
            HomeView(viewModel: HomeViewModel())
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
            
            PostDetailView(viewModel: PostDetailViewModel(post: Post(id: UUID(), title: "test", body: "test", timestamp: Date(), comments: [], donations: 0, owner: User(walletAddress: "test", username: "test", email: "test"))))
                .tabItem {
                    Image(systemName: "bubble.left.and.bubble.right.fill")
                    Text("Post Details")
                }
            
            ProfileView(viewModel: ProfileViewModel())
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Profile")
                }
        }
        .accentColor(.primary)
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
