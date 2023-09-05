//
//  PostDetailViewModel.swift
//  CryptoConnect
//
//  Created by Melissa Zellhuber on 04/09/23.
//

import SwiftUI
import Combine

class PostDetailViewModel: ObservableObject {
    @Published var post: Post
    
    private let dateFormatter: DateFormatter
    
    init(post: Post) {
        self.post = post
        
        self.dateFormatter = DateFormatter()
        self.dateFormatter.dateStyle = .short
        self.dateFormatter.timeStyle = .short
    }
    
    var formattedDate: String {
        return dateFormatter.string(from: post.timestamp)
    }
    
    func fetchPostDetails() {
        // Your code to fetch post details and assign to the post property
    }
}
