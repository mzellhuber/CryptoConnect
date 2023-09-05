//
//  HomeViewModel.swift
//  CryptoConnect
//
//  Created by Melissa Zellhuber on 04/09/23.
//

import SwiftUI
import Combine

class HomeViewModel: ObservableObject {
    @Published var posts: [Post] = []
    
    init() {
        fetchPosts()
    }
    
    func fetchPosts() {
        let comments1 = [
            Comment(id: UUID(), username: "User1", timestamp: Date(), body: "Great post!"),
            Comment(id: UUID(), username: "User2", timestamp: Date(), body: "Very informative, thanks!")
        ]
        
        let comments2 = [
            Comment(id: UUID(), username: "User3", timestamp: Date(), body: "Interesting perspective."),
            Comment(id: UUID(), username: "User4", timestamp: Date(), body: "Thanks for sharing!")
        ]
        
        let comments3 = [
            Comment(id: UUID(), username: "User5", timestamp: Date(), body: "I agree with this."),
            Comment(id: UUID(), username: "User6", timestamp: Date(), body: "Well written!")
        ]
        
        self.posts = [
            Post(id: UUID(), title: "First Post", body: "This is the body of the first post.", timestamp: Date(), comments: comments1),
            Post(id: UUID(), title: "Second Post", body: "This is the body of the second post.", timestamp: Date().addingTimeInterval(-3600), comments: comments2),
            Post(id: UUID(), title: "Third Post", body: "This is the body of the third post.", timestamp: Date().addingTimeInterval(-7200), comments: comments3)
        ]
    }
}
