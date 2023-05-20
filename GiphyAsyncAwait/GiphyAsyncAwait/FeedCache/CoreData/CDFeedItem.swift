//
//  CDFeedItem+CoreDataProperties.swift
//  GiphyAsyncAwait
//
//  Created by Varun on 19/05/23.
//
//

import Foundation
import CoreData

@objc(CDFeedItem)
public class CDFeedItem: NSManagedObject {
    @NSManaged public var id: String
    @NSManaged public var title: String
    @NSManaged public var dateTime: String?
    @NSManaged public var originalImageUrl: URL
    @NSManaged public var originalImageWidth: String
    @NSManaged public var originalImageHeight: String
    @NSManaged public var smallImageUrl: URL
    @NSManaged public var smallImageWidth: String
    @NSManaged public var smallImageHeight: String
    @NSManaged public var userName: String?
    @NSManaged public var userDisplayName: String?
    @NSManaged public var page: CDFeedPage
    
    static func feedItems(from localFeed: [LocalFeed], in context: NSManagedObjectContext) -> NSOrderedSet {
        return NSOrderedSet(array: localFeed.map { local in
            let feedItem = CDFeedItem(context: context)
            feedItem.id = local.id
            feedItem.title = local.title
            feedItem.dateTime = local.datetime
            feedItem.originalImageUrl = local.images.original.url
            feedItem.originalImageWidth = local.images.original.width
            feedItem.originalImageHeight = local.images.original.height
            feedItem.smallImageUrl = local.images.small.url
            feedItem.smallImageWidth = local.images.small.width
            feedItem.smallImageHeight = local.images.small.height
            feedItem.userName = local.user?.username
            feedItem.userDisplayName = local.user?.displayName
            return feedItem
        })
    }
    
    var local: LocalFeed {
        LocalFeed(id: id, title: title, datetime: dateTime, images: LocalFeedImages(original: LocalFeedImageMetadata(height: originalImageHeight, width: originalImageWidth, url: originalImageUrl), small: LocalFeedImageMetadata(height: smallImageHeight, width: smallImageWidth, url: smallImageUrl)), user: LocalFeedUser(username: userName ?? "", displayName: userDisplayName ?? ""))
    }
}
