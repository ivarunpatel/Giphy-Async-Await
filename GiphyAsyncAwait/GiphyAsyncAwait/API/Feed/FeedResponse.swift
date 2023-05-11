//
//  FeedResponse.swift
//  GiphyAsyncAwait
//
//  Created by Varun on 11/05/23.
//

import Foundation

public struct FeedResponse: Decodable {
    public let data: [FeedData]
    public let pagination: FeedPagination
    
    public init(data: [FeedData], pagination: FeedPagination) {
        self.data = data
        self.pagination = pagination
    }
}

public extension FeedResponse {
    struct FeedData: Decodable {
        let id: String
        let title: String
        let datetime: String?
        let images: FeedImages
        let user: FeedUser?
        
        public init(id: String, title: String, datetime: String?, images: FeedImages, user: FeedUser?) {
            self.id = id
            self.title = title
            self.datetime = datetime
            self.images = images
            self.user = user
        }
        
        enum CodingKeys: String, CodingKey {
            case id
            case title
            case datetime = "trending_datetime"
            case images
            case user
        }
        
        public struct FeedImages: Decodable {
            let original: FeedImageMetadata
            let small: FeedImageMetadata
            
            public init(original: FeedImageMetadata, small: FeedImageMetadata) {
                self.original = original
                self.small = small
            }
            
            enum CodingKeys: String, CodingKey {
                case original
                case small = "fixed_width_small"
            }
            
            public struct FeedImageMetadata: Decodable {
                let height: String
                let width: String
                let url: URL
                
                public init(height: String, width: String, url: URL) {
                    self.height = height
                    self.width = width
                    self.url = url
                }
            }
        }
        
        public struct FeedUser: Decodable {
            let username: String
            let displayName: String
            
            public init(username: String, displayName: String) {
                self.username = username
                self.displayName = displayName
            }
            
            enum CodingKeys: String, CodingKey {
                case username
                case displayName = "display_name"
            }
        }
    }
    
    struct FeedPagination: Decodable {
        let totalCount: Int
        let count: Int
        let offset: Int
        
        public init(totalCount: Int, count: Int, offset: Int) {
            self.totalCount = totalCount
            self.count = count
            self.offset = offset
        }
        
        enum CodingKeys: String, CodingKey {
            case totalCount = "total_count"
            case count
            case offset
        }
    }
}

// MARK: - Mappings to Domain
public extension FeedResponse {
    func toDomain() -> FeedPage {
        FeedPage(totalCount: pagination.totalCount, count: pagination.count, offset: pagination.offset, giphy: data.map { $0.toDomain() })
    }
}

extension FeedResponse.FeedData {
    func toDomain() -> Feed {
        Feed(id: id, title: title, datetime: datetime, images: images.toDomain(), user: user?.toDomain())
    }
}

extension FeedResponse.FeedData.FeedImages {
    func toDomain() -> FeedImages {
        FeedImages(original: original.toDomain(), small: small.toDomain())
    }
}

extension FeedResponse.FeedData.FeedImages.FeedImageMetadata {
    func toDomain() -> FeedImageMetadata {
        FeedImageMetadata(height: height, width: width, url: url)
    }
}

extension FeedResponse.FeedData.FeedUser {
    func toDomain() -> FeedUser {
        FeedUser(username: username, displayName: displayName)
    }
}
