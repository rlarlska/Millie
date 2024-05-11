//
//  ContentView.swift
//  Millie
//
//  Created by 김기남 on 2024/05/07.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = NewsViewModel()
    @State private var isPortrait = true
    var columns : [GridItem] {
        Array(
            repeating: GridItem(.flexible()),
            count: isPortrait ? 1 : 5
        )
    }
    
    init() {
        UIScrollView.appearance().bounces = false
    }
    
    var body: some View {
        NavigationStack {
            ScrollView(isPortrait ? .vertical : [.horizontal, .vertical]) {
                LazyVGrid(columns: self.columns) {
                    ForEach(self.viewModel.articles, id: \.id) { realmArticle in
                        NavigationLink {
                            WebView(urlString: realmArticle.url)
                                .navigationTitle(realmArticle.title)
                        } label: {
                            Group {
                                if isPortrait {
                                    PortraitGridItemView(
                                        title: realmArticle.title,
                                        isRead: realmArticle.isRead,
                                        urlToImage: realmArticle.urlToImage,
                                        imageData: realmArticle.imageData,
                                        publishedAt: realmArticle.publishedAt) { imageData in
                                            self.viewModel.updateData(
                                                realmArticle: realmArticle,
                                                imageData: imageData
                                            )
                                        }
                                } else {
                                    LandscapeGridItemView(
                                        title: realmArticle.title,
                                        isRead: realmArticle.isRead,
                                        urlToImage: realmArticle.urlToImage,
                                        imageData: realmArticle.imageData,
                                        publishedAt: realmArticle.publishedAt) { imageData in
                                            self.viewModel.updateData(
                                                realmArticle: realmArticle,
                                                imageData: imageData
                                            )
                                        }
                                }
                            }
                            .padding()
                            .frame(maxWidth: isPortrait ? CGFLOAT_MAX : 300,
                                   maxHeight: isPortrait ? CGFLOAT_MAX : 120)
                            .background(Color(white: 0.5, opacity: 0.5))
                            .cornerRadius(10)
                        }
                        .buttonStyle(PlainButtonStyle())
                        .simultaneousGesture(TapGesture().onEnded({
                            self.viewModel.setRead(realmArticle: realmArticle)
                        }))
                    }
                }
                .frame(minWidth: isPortrait ? 0 : 1550)
                .onRotate { isPortrait in
                    self.isPortrait = isPortrait
                }
            }
            .scrollIndicators(.hidden)
        }
    }
}
