//
//  CreatePostViewModel.swift
//  CryptoConnect
//
//  Created by Melissa Zellhuber on 06/09/23.
//

import SwiftUI
import Combine

class CreatePostViewModel: ObservableObject {
    @Published var title: String = ""
    @Published var body: String = ""
    
    func createPost(title: String, body: String) {
        // Handle post creation
    }
}
