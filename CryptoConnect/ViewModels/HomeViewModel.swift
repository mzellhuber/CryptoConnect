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
        
    }
}
