//
//  LocalFeedModel.swift
//  GiphyAsyncAwait
//
//  Created by Varun on 19/05/23.
//

import Foundation

public struct LocalFeed: Equatable {
    public let id: String
    public let title: String
    public let datetime: String?
    public let images: LocalFeedImages
    public let user: LocalFeedUser?
    
    public init(id: String, title: String, datetime: String?, images: LocalFeedImages, user: LocalFeedUser?) {
        self.id = id
        self.title = title
        self.datetime = datetime
        self.images = images
        self.user = user
    }
}

public struct LocalFeedImages: Equatable {
    public let original: LocalFeedImageMetadata
    public let small: LocalFeedImageMetadata
    
    public init(original: LocalFeedImageMetadata, small: LocalFeedImageMetadata) {
        self.original = original
        self.small = small
    }
}

public struct LocalFeedImageMetadata: Equatable {
    public let height: String
    public let width: String
    public let url: URL
    
    public init(height: String, width: String, url: URL) {
        self.height = height
        self.width = width
        self.url = url
    }
}

public struct LocalFeedUser: Equatable {
    public let username: String
    public let displayName: String
    
    public init(username: String, displayName: String) {
        self.username = username
        self.displayName = displayName
    }
}

public struct LocalFeedPage: Equatable {
    public let totalCount: Int
    public let count: Int
    public let offset: Int
    public let giphy: [LocalFeed]
    
    public init(totalCount: Int, count: Int, offset: Int, giphy: [LocalFeed]) {
        self.totalCount = totalCount
        self.count = count
        self.offset = offset
        self.giphy = giphy
    }
}
