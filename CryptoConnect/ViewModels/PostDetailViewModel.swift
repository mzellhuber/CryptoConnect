//
//  PostDetailViewModel.swift
//  CryptoConnect
//
//  Created by Melissa Zellhuber on 04/09/23.
//

import Foundation
import Combine

class PostDetailViewModel: ObservableObject {
    @Published var post: Post?
    
    func fetchPostDetails(postID: UUID) {
        // Here you would fetch the post details from your data source
        // For now, I'll create a dummy post with some comments
        
        let comments = [
            Comment(id: UUID(), username: "User1", timestamp: Date(), body: "Great post!"),
            Comment(id: UUID(), username: "User2", timestamp: Date(), body: "Very informative, thanks!")
        ]
        
        let post = Post(id: postID, title: "Sample Post", body: "This is a sample post body.", timestamp: Date(), comments: comments)
        
        self.post = post
    }
}
