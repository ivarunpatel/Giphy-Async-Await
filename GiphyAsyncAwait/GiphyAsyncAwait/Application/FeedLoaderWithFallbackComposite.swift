//
//  FeedLoaderWithFallbackComposite.swift
//  GiphyAsyncAwait
//
//  Created by Varun on 19/05/23.
//

import Foundation

public final class FeedLoaderWithFallbackComposite: FeedLoader {
    let primary: FeedLoader
    let fallback: FeedLoader
    
    init(primary: FeedLoader, fallback: FeedLoader) {
        self.primary = primary
        self.fallback = fallback
    }
    
    func load(limit: Int, offset: Int) async throws -> FeedPage {
        do {
            return try await primary.load(limit: limit, offset: offset)
        } catch {
            return try await fallback.load(limit: limit, offset: offset)
        }
    }
}
