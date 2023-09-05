//
//  MainTabView.swift
//  CryptoConnect
//
//  Created by Melissa Zellhuber on 05/09/23.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            HomeView(viewModel: HomeViewModel())
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
            
            PostDetailView(viewModel: PostDetailViewModel(post: Post(id: UUID(), title: "test", body: "test", timestamp: Date(), comments: [])))
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
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
