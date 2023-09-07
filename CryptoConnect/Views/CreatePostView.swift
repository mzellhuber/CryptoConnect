//
//  CreatePostView.swift
//  CryptoConnect
//
//  Created by Melissa Zellhuber on 04/09/23.
//

import SwiftUI

struct CreatePostView: View {
    @StateObject var viewModel = CreatePostViewModel()
    
    @State private var postTitle = ""
    @State private var postBody = ""
    
    var body: some View {
        VStack(spacing: 20) {
            TextField("Post Title", text: $postTitle, prompt: Text("Post Title").foregroundColor(.gray))
                .padding()
                .background(ColorPalette.secondaryBackground)
                .cornerRadius(8)
                .padding(.horizontal)
            
            TextEditor(text: $postBody)
                .foregroundColor(.gray)
                .padding()
                .background(ColorPalette.secondaryBackground)
                .cornerRadius(8)
                .padding(.horizontal)
                .frame(height: 200)
            
            CustomButton(title: "Create Post", action: {
                // Handle create post action
                viewModel.createPost(title: postTitle, body: postBody)
            })
            .padding(.horizontal)
            
            Spacer()
        }
        .padding(.top, 100)
        .background(ColorPalette.primaryBackground)
        .edgesIgnoringSafeArea(.all)
        .navigationBarTitle("Create Post", displayMode: .inline)
    }
}

struct CreatePostView_Previews: PreviewProvider {
    static var previews: some View {
        CreatePostView()
    }
}
