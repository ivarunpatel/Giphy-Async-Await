//
//  FeedResponseMapper.swift
//  GiphyAsyncAwait
//
//  Created by Varun on 11/05/23.
//

import Foundation

struct FeedResponseMapper {
    static func map(data: Data) throws -> FeedPage {
        guard let feedPage = try? JSONDecoder().decode(FeedResponse.self, from: data) else {
            throw HTTPClientError.invalidData
        }
        return feedPage.toDomain()
    }
}
