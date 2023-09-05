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
        // Here you can initialize your posts array with some data,
        // or fetch the data from a network request.
        // For now, I'm adding some dummy data.
        self.posts = [
                    Post(id: UUID(), title: "First Post", body: "This is the body of the first post.", timestamp: Date()),
                    Post(id: UUID(), title: "Second Post", body: "This is the body of the second post.", timestamp: Date().addingTimeInterval(-3600)),
                    Post(id: UUID(), title: "Third Post", body: "This is the body of the third post.", timestamp: Date().addingTimeInterval(-7200))
                ]
        fetchPosts()
    }
    
    func fetchPosts() {
        self.posts = [
                    Post(id: UUID(), title: "First Post", body: "This is the body of the first post.", timestamp: Date()),
                    Post(id: UUID(), title: "Second Post", body: "This is the body of the second post.", timestamp: Date().addingTimeInterval(-3600)),
                    Post(id: UUID(), title: "Third Post", body: "This is the body of the third post.", timestamp: Date().addingTimeInterval(-7200))
                ]
        }
}
