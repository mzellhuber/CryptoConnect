//
//  PostDetailView.swift
//  CryptoConnect
//
//  Created by Melissa Zellhuber on 04/09/23.
//

import SwiftUI
import BigInt

struct PostDetailView: View {
    @ObservedObject var viewModel: PostDetailViewModel
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                ScrollView {
                    VStack(alignment: .center, spacing: 20) {
                        ZStack {
                            ColorPalette.secondaryBackground
                                .cornerRadius(10)
                                .shadow(color: .gray.opacity(0.5), radius: 2, x: 0, y: 2)
                            
                            VStack(alignment: .center, spacing: 10) {
                                Text(viewModel.post.title)
                                    .font(Typography.header)
                                    .foregroundColor(ColorPalette.primaryText)
                                    .padding()
                                
                                Text(viewModel.formattedDate)
                                    .font(Typography.caption)
                                    .foregroundColor(ColorPalette.secondaryText)
                                    .padding()
                                
                                Text(viewModel.post.body)
                                    .font(Typography.bodyText)
                                    .foregroundColor(ColorPalette.primaryText)
                                    .padding()
                            }
                        }
                        .frame(width: geometry.size.width, height: geometry.size.height / 2)
                        
                        ScrollView(.vertical, showsIndicators: false) {
                            VStack(alignment: .center, spacing: 20) {
                                ForEach(viewModel.post.comments) { comment in
                                    CommentView(comment: comment)
                                }
                            }
                        }
                    }
                }
                .background(ColorPalette.primaryBackground.edgesIgnoringSafeArea(.all))
                .navigationBarTitleDisplayMode(.automatic)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Text("Post Details")
                            .font(Typography.header)
                            .foregroundColor(ColorPalette.navigationText)
                    }
                }
                .onAppear {
                    viewModel.fetchPostDetails()
                }
            }
            .background(ColorPalette.primaryBackground.edgesIgnoringSafeArea(.all))
        }
    }
}

struct PostDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let sampleUser = User(walletAddress: "0x1234567890abcdef", username: "JohnDoe", email: "john.doe@example.com")
        
        let sampleComments = [
            Comment(id: UUID(), username: "Commenter1", timestamp: Date(), body: "This is a comment."),
            Comment(id: UUID(), username: "Commenter2", timestamp: Date(), body: "This is another comment.")
        ]
        
        let samplePost = Post(id: UUID(), title: "Sample Post", body: "This is a sample post body.", timestamp: Date(), comments: sampleComments, donations: BigUInt(100), owner: sampleUser)
        
        let viewModel = PostDetailViewModel(post: samplePost)
        
        return PostDetailView(viewModel: viewModel)
    }
}
