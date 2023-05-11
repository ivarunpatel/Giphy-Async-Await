//
//  FeedViewModel.swift
//  GiphyAsyncAwait
//
//  Created by Varun on 11/05/23.
//

import Foundation

@MainActor
public class FeedViewModel: ObservableObject {
    
    let feedLoader: FeedLoader
    
    init(feedLoader: FeedLoader) {
        self.feedLoader = feedLoader
    }
    
    @Published var items: [FeedListItemViewModel] = []
    private var pages: [FeedPage] = []
    
    func loadFeed() async {
        do {
            let feedPage = try await feedLoader.load(limit: 10, offset: 0)
            pages = pages.filter { $0.offset != $0.offset } + [feedPage]
            items = pages.flatMap { $0.giphy }.map(FeedListItemViewModel.init)
        } catch {
            print(error)
        }
    }
}
