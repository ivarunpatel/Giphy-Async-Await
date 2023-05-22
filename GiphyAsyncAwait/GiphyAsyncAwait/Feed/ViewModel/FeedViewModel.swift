//
//  FeedViewModel.swift
//  GiphyAsyncAwait
//
//  Created by Varun on 11/05/23.
//

import Foundation

public enum FeedViewModelState: Equatable {
    case loading
    case nextPage
}

public class FeedViewModel: ObservableObject {
    
    let feedLoader: FeedLoader
    
    init(feedLoader: FeedLoader) {
        self.feedLoader = feedLoader
    }
    
    @Published var items: [FeedListItemViewModel] = []
    @Published var state: FeedViewModelState? = .none
    
    private let parPageItem = 10
    private var totalCount = 0
    private var count = 0
    private var offSet = 0
    private var hasMorePage: Bool {
        count <= totalCount
    }
    private var nextPage: Int {
        if hasMorePage && count == 0 {
            return 0
        } else if hasMorePage && count > 0 {
            return offSet + parPageItem
        } else {
            return offSet
        }
    }
    private var pages: [FeedPage] = []
    
    @MainActor private func loadFeed(state: FeedViewModelState) async {
        self.state = state
        do {
            let feedPage = try await feedLoader.load(limit: parPageItem, offset: nextPage)
            appendPage(feedPage: feedPage)
        } catch {
            print(error)
        }
        
        self.state = .none
    }
    
    @MainActor private func appendPage(feedPage: FeedPage) {
        totalCount = feedPage.totalCount
        count = feedPage.count
        offSet = feedPage.offset
        
        pages = pages.filter { $0.offset != feedPage.offset } + [feedPage]
        items = pages.flatMap { $0.giphy }.map(FeedListItemViewModel.init)
    }
    
    private func resetPages() {
        totalCount = 0
        count = 0
        offSet = 0
        
        pages.removeAll()
    }
    
    public func viewDidAppear() async {
        await loadFeed(state: .loading)
    }
    
    public func didLoadNextPage() async {
        guard hasMorePage else { return }
        await loadFeed(state: .nextPage)
    }
}
