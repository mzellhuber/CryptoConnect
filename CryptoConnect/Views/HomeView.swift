//
//  HomeView.swift
//  CryptoConnect
//
//  Created by Melissa Zellhuber on 04/09/23.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel: HomeViewModel
    private let dateFormatter: DateFormatter

    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        self.dateFormatter = DateFormatter()
        self.dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    }

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    ForEach(viewModel.posts) { post in
                        VStack(alignment: .leading, spacing: 10) {
                            Text(post.title)
                                .font(Typography.header)
                                .foregroundColor(ColorPalette.primaryText)
                            
                            Text(dateFormatter.string(from: post.timestamp))
                                .font(Typography.subtleText)
                                .foregroundColor(ColorPalette.secondaryText)
                            
                            Text(post.body)
                                .font(Typography.bodyText)
                                .foregroundColor(ColorPalette.primaryText)
                                .lineLimit(2)
                        }
                        .padding()
                        .background(ColorPalette.secondaryBackground)
                        .cornerRadius(8)
                        .padding(.horizontal)
                    }
                }
                .padding(.top, 20)
            }
            .background(ColorPalette.primaryBackground.edgesIgnoringSafeArea(.all))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Home Feed")
                        .font(Typography.header)
                        .foregroundColor(ColorPalette.navigationText)
                }
            }
            .onAppear {
                viewModel.fetchPosts()
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(viewModel: HomeViewModel())
    }
}
