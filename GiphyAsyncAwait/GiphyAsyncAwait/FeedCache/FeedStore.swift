//
//  FeedStore.swift
//  GiphyAsyncAwait
//
//  Created by Varun on 19/05/23.
//

import Foundation

public protocol FeedStore {
    func insert(feed: LocalFeedPage) async throws
    func retrieveCache() async throws -> LocalFeedPage?
    func deleteCache() async throws
}
