//
//  PostDetailView.swift
//  CryptoConnect
//
//  Created by Melissa Zellhuber on 04/09/23.
//

import SwiftUI

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

struct CommentView: View {
    let comment: Comment
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter
    }()
    
    var body: some View {
        ZStack {
            ColorPalette.secondaryBackground
                .cornerRadius(10)
                .shadow(color: .gray.opacity(0.5), radius: 2, x: 0, y: 2)
            
            VStack(alignment: .center, spacing: 10) {
                Text(comment.username)
                    .font(Typography.bodyText)
                    .foregroundColor(ColorPalette.primaryText)
                    .padding(.top)
                
                Text(dateFormatter.string(from: comment.timestamp))
                    .font(Typography.caption)
                    .foregroundColor(ColorPalette.secondaryText)
                
                Text(comment.body)
                    .font(Typography.bodyText)
                    .foregroundColor(ColorPalette.primaryText)
                    .padding(.bottom)
            }
            .padding(.horizontal)
        }
    }
}

struct PostDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let post = Post(id: UUID(), title: "Sample Post", body: "This is a sample post.", timestamp: Date(), comments: [
            Comment(id: UUID(), username: "User1", timestamp: Date(), body: "Great post!"),
            Comment(id: UUID(), username: "User2", timestamp: Date(), body: "Very informative, thanks!"),
            Comment(id: UUID(), username: "User3", timestamp: Date(), body: "Great post! I learned a lot."),
            Comment(id: UUID(), username: "User4", timestamp: Date(), body: "This is very helpful. Thank you for sharing."),
            Comment(id: UUID(), username: "User5", timestamp: Date(), body: "I'm glad you found this post helpful."),
            Comment(id: UUID(), username: "User6", timestamp: Date(), body: "I have a question about this. Can you help me?"),
            Comment(id: UUID(), username: "User7", timestamp: Date(), body: "I'm also interested in this topic. Can you share more information?"),
            Comment(id: UUID(), username: "User8", timestamp: Date(), body: "This is a great discussion. I'm glad I found this post."),
            Comment(id: UUID(), username: "User9", timestamp: Date(), body: "I'm new to this topic. Can you recommend some resources?"),
            Comment(id: UUID(), username: "User10", timestamp: Date(), body: "I'm so glad I found this post. It's exactly what I was looking for."),
            Comment(id: UUID(), username: "User11", timestamp: Date(), body: "Thanks for sharing this! I'm definitely going to try this out."),
            Comment(id: UUID(), username: "User12", timestamp: Date(), body: "This is amazing! I can't believe I didn't know about this before.")
        ])
        
        let postViewModel = PostDetailViewModel(post: post)
        PostDetailView(viewModel: postViewModel)
    }
}
