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
        self.dateFormatter.dateStyle = .short
        self.dateFormatter.timeStyle = .short
    }

    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                ScrollView {
                    LazyVStack(spacing: 20) {
                        ForEach(viewModel.posts) { post in
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
                        Text("Home Feed")
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
        HomeView(viewModel: HomeViewModel())
    }
}
