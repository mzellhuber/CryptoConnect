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
