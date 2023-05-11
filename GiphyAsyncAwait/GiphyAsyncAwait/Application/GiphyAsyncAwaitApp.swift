//
//  GiphyAsyncAwaitApp.swift
//  GiphyAsyncAwait
//
//  Created by Varun on 11/05/23.
//

import SwiftUI

@main
struct GiphyAsyncAwaitApp: App {
    var body: some Scene {
        WindowGroup {
            let appConfiguration = AppConfiguration()
            let networkConfigurable = ApiNetworkConfig(baseURL: URL(string: appConfiguration.baseURL)!, headers: [:], queryParameters: ["api_key": appConfiguration.apiKey, "rating": "g"])
            let httpClient = URLSessionHTTPClient(networkConfigurable: networkConfigurable)
            let remoteFeedLoader = RemoteFeedLoader(httpClient: httpClient)
            let feedViewModel = FeedViewModel(feedLoader: remoteFeedLoader)
            FeedView(viewModel: feedViewModel)
        }
    }
}
