//
//  FeedLoader.swift
//  GiphyAsyncAwait
//
//  Created by Varun on 11/05/23.
//

import Foundation

protocol FeedLoader {
    func load(limit: Int, offset: Int) async throws -> FeedPage
}
