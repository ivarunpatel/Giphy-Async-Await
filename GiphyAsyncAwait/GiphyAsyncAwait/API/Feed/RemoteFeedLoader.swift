//
//  RemoteFeedLoader.swift
//  GiphyAsyncAwait
//
//  Created by Varun on 11/05/23.
//

import Foundation
import NetFlow

final class RemoteFeedLoader: FeedLoader {
    private let httpClient: HTTPClient
    
    public init(httpClient: HTTPClient) {
        self.httpClient = httpClient
    }
    
    private var OK_200: Int { 200 }
    
    func load(limit: Int, offset: Int) async throws -> FeedPage {
        let queryParameters = ["limit": limit, "offset": offset]
        let feedEndpoint = FeedEndpoint(queryParameters: queryParameters)
        let (data, response) = try await httpClient.execute(request: feedEndpoint)
        guard (response as? HTTPURLResponse)?.statusCode == OK_200 else {
            throw HTTPClientError.connectivity
        }
        return try FeedResponseMapper.map(data: data)
    }
}
