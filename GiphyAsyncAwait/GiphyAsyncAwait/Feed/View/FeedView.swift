//
//  FeedView.swift
//  GiphyAsyncAwait
//
//  Created by Varun on 11/05/23.
//

import SwiftUI

struct FeedView: View {
    @ObservedObject private(set) public var viewModel: FeedViewModel
    
    init(viewModel: FeedViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ScrollView {
            if viewModel.state == .loading {
                ProgressView("Loading...")
                    .frame(width: 100, height: 100)
            }
            LazyVStack(spacing: 10) {
                ForEach(viewModel.items.indices, id: \.self) { index in
                    let feedListItemViewModel = viewModel.items[index]
                    FeedListItemView(viewModel: feedListItemViewModel)
                        .onAppear {
                            if  index == viewModel.items.count - 1 {
                                Task {
                                    await viewModel.didLoadNextPage()
                                }
                            }
                        }
                }
                if viewModel.state == .nextPage {
                    ProgressView("Loading next page...")
                }
            }
        }.task {
            await viewModel.viewDidAppear()
        }
        .background(Color.black)
    }
}

struct FeedViewPreviewLoader: FeedLoader {
    func load(limit: Int, offset: Int) async throws -> FeedPage {
        FeedPage(totalCount: 1, count: 1, offset: 0, giphy: [Feed(id: "123", title: "Happy Formula E GIF by Jaguar TCS Racing", datetime: "2023-05-11 20:31:03", images: FeedImages(original: FeedImageMetadata(height: "270", width: "480", url: URL(string: "https://media4.giphy.com/media/3evfM16yrMtQjrStbt/giphy.gif?cid=a73e0a9dc5kwahp7og6akzyhrqcuufkswvo44f0ebjdbpt8c&ep=v1_gifs_trending&rid=giphy.gif&ct=g")!), small: FeedImageMetadata(height: "200", width: "200", url: URL(string: "https://media4.giphy.com/media/DyQrKMpqkAhNHZ1iWe/200w_s.gif?cid=a73e0a9dc5kwahp7og6akzyhrqcuufkswvo44f0ebjdbpt8c&ep=v1_gifs_trending&rid=200w_s.gif&ct=g")!)), user: FeedUser(username: "chippythedog", displayName: "Chippy the Dog"))])
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView(viewModel: FeedViewModel(feedLoader: FeedViewPreviewLoader()))
    }
}
