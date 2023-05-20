//
//  FeedCache.swift
//  GiphyAsyncAwait
//
//  Created by Varun on 20/05/23.
//

import Foundation

public protocol FeedCache {
    func save(_ feed: FeedPage) async throws
}
