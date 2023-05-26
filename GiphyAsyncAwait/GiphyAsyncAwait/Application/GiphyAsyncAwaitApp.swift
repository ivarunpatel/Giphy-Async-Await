//
//  GiphyAsyncAwaitApp.swift
//  GiphyAsyncAwait
//
//  Created by Varun on 11/05/23.
//

import SwiftUI
import CoreData
import NetFlow

@main
struct GiphyAsyncAwaitApp: App {
    var body: some Scene {
        WindowGroup {
            let appConfiguration = AppConfiguration()
            let networkConfigurable = ApiNetworkConfig(baseURL: URL(string: appConfiguration.baseURL)!, headers: [:], queryParameters: ["api_key": appConfiguration.apiKey, "rating": "g"])
            let httpClient = URLSessionHTTPClient(networkConfigurable: networkConfigurable)
            let remoteFeedLoader = RemoteFeedLoader(httpClient: httpClient)
            let coreDataStore = try! CoreDataFeedStore(storeURL: NSPersistentContainer.defaultDirectoryURL().appending(path: "giphy-store.sqlite"))
            let localFeedLoader = LocalFeedLoader(store: coreDataStore)
            let feedLoaderCache = FeedLoaderCacheDecorator(decoratee: remoteFeedLoader, cache: localFeedLoader)
            let fallbackLoader = FeedLoaderWithFallbackComposite(primary: feedLoaderCache, fallback: localFeedLoader)
            let feedViewModel = FeedViewModel(feedLoader: fallbackLoader)
            FeedView(viewModel: feedViewModel)
        }
    }
}
