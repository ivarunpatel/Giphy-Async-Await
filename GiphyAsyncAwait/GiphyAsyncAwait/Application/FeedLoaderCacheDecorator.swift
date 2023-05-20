//
//  FeedLoaderCacheDecorator.swift
//  GiphyAsyncAwait
//
//  Created by Varun on 20/05/23.
//

import Foundation

public final class FeedLoaderCacheDecorator: FeedLoader {
    let decoratee: FeedLoader
    let cache: FeedCache
    
    init(decoratee: FeedLoader, cache: FeedCache) {
        self.decoratee = decoratee
        self.cache = cache
    }
    
    func load(limit: Int, offset: Int) async throws -> FeedPage {
        var feedPage: FeedPage
        do {
            feedPage = try await decoratee.load(limit: limit, offset: offset)
            try await cache.save(feedPage)
        } catch {
            throw error
        }
        
        return feedPage
    }
}
