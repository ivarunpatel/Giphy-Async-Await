//
//  LocalFeedLoader.swift
//  GiphyAsyncAwait
//
//  Created by Varun on 19/05/23.
//

import Foundation

public enum LocalFeedError: Error {
    case noCache
}

final class LocalFeedLoader {
    let store: FeedStore
    
    init(store: FeedStore) {
        self.store = store
    }
}

extension LocalFeedLoader: FeedCache {
    func save(_ feed: FeedPage) async throws {
        try await store.insert(feed: feed.toLocal())
    }
    
    func deleteCachedFeed() async throws {
        try await store.deleteCache()
    }
}

extension LocalFeedLoader: FeedLoader {
    func load(limit: Int, offset: Int) async throws -> FeedPage {
        let cache = try await store.retrieveCache(offset: offset)
        if let cache = cache {
            return cache.toDomain()
        } else {
            throw LocalFeedError.noCache
        }
    }
}
