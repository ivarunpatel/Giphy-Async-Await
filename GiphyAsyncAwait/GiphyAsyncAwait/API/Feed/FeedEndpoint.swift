//
//  FeedEndpoint.swift
//  GiphyAsyncAwait
//
//  Created by Varun on 11/05/23.
//

import Foundation

struct FeedEndpoint: Requestable {
    var path: String = "/v1/gifs/trending"
    var isFullPath: Bool = false
    var method: HTTPMethodType = .get
    var queryParameters: [String : Any] = [:]
}
