//
//  HomeView.swift
//  CryptoConnect
//
//  Created by Melissa Zellhuber on 04/09/23.
//

import SwiftUI
import web3swift
import Web3Core
import BigInt

struct HomeView: View {
    @ObservedObject var viewModel: HomeViewModel
    @StateObject private var web3Manager = Web3Manager()
    private let dateFormatter: DateFormatter
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        self.dateFormatter = DateFormatter()
        self.dateFormatter.dateStyle = .short
        self.dateFormatter.timeStyle = .short
    }
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                ScrollView {
                    LazyVStack(spacing: 20) {
                        ForEach(viewModel.posts.indices, id: \.self) { index in
                            let post = viewModel.posts[index]
                            ZStack {
                                ColorPalette.secondaryBackground
                                    .cornerRadius(10)
                                    .shadow(color: .gray.opacity(0.5), radius: 2, x: 0, y: 2)
                                
                                VStack(alignment: .leading, spacing: 10) {
                                    Text(post.title)
                                        .font(Typography.header)
                                        .foregroundColor(ColorPalette.primaryText)
                                        .padding([.top, .horizontal])
                                    
                                    Text(dateFormatter.string(from: post.timestamp))
                                        .font(Typography.caption)
                                        .foregroundColor(ColorPalette.secondaryText)
                                        .padding(.horizontal)
                                    
                                    Text(post.body)
                                        .font(Typography.bodyText)
                                        .foregroundColor(ColorPalette.primaryText)
                                        .lineLimit(3)
                                        .padding([.bottom, .horizontal])
                                    
                                    if let walletAddress = EthereumAddress(post.owner.walletAddress) {
                                        TipButton(walletAddress: walletAddress, web3Manager: web3Manager)
                                            .padding([.horizontal, .bottom])
                                    } else {
                                        // Handle the error case here, perhaps with a Text view displaying an error message
                                        Text("Invalid wallet address")
                                            .foregroundColor(.red)
                                            .padding([.horizontal, .bottom])
                                    }


                                }
                            }
                            .frame(width: geometry.size.width - 40)
                        }
                    }
                    .padding(.top, 20)
                }
                .background(ColorPalette.primaryBackground.edgesIgnoringSafeArea(.all))
                .navigationBarTitleDisplayMode(.automatic)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Text("CryptoConnect")
                            .font(Typography.header)
                            .foregroundColor(ColorPalette.navigationText)
                    }
                }
                .onAppear {
                    viewModel.fetchPosts()
                }
            }
            .background(ColorPalette.primaryBackground.edgesIgnoringSafeArea(.all))
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        let sampleUser = User(walletAddress: "0x1234567890abcdef", username: "JohnDoe", email: "john.doe@example.com")
        
        let sampleComments = [
            Comment(id: UUID(), username: "Commenter1", timestamp: Date(), body: "This is a comment."),
            Comment(id: UUID(), username: "Commenter2", timestamp: Date(), body: "This is another comment.")
        ]
        
        let samplePosts = [
            Post(id: UUID(), title: "Sample Post 1", body: "This is a sample post body.", timestamp: Date(), comments: sampleComments, donations: BigUInt(100), owner: sampleUser),
            Post(id: UUID(), title: "Sample Post 2", body: "This is another sample post body.", timestamp: Date(), comments: sampleComments, donations: BigUInt(50), owner: sampleUser)
        ]
        
        let viewModel = HomeViewModel()
        viewModel.posts = samplePosts
        
        return HomeView(viewModel: viewModel)
    }
}
