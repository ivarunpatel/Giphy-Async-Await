//
//  FeedStore.swift
//  GiphyAsyncAwait
//
//  Created by Varun on 19/05/23.
//

import Foundation

public protocol FeedStore {
    func save(feed: LocalFeedPage) async throws
}
