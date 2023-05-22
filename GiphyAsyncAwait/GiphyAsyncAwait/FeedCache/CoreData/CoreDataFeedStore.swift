//
//  CoreDataFeedStore.swift
//  GiphyAsyncAwait
//
//  Created by Varun on 19/05/23.
//

import Foundation
import CoreData

public final class CoreDataFeedStore: FeedStore {
    
    let container: NSPersistentContainer
    let context: NSManagedObjectContext
    
    init(storeURL: URL, bundle: Bundle = .main) throws {
        container = try NSPersistentContainer.load(modelName: "GiphyStore", url: storeURL, in: bundle)
        context = container.newBackgroundContext()
    }
    
    public func insert(feed: LocalFeedPage) async throws {
        try await context.perform { [context] in
            let cdFeedPageContext = CDFeedPage(context: context)
            cdFeedPageContext.totalCount = Int16(feed.totalCount)
            cdFeedPageContext.count = Int16(feed.count)
            cdFeedPageContext.offset = Int16(feed.offset)
            cdFeedPageContext.giphy = CDFeedItem.feedItems(from: feed.giphy, in: context)
            try context.save()
        }
    }
    
    public func retrieveCache(offset: Int) async throws -> LocalFeedPage? {
        try await context.perform { [context] in
            try CDFeedPage.find(with: offset, in: context).map { feedPage in
                LocalFeedPage(totalCount: Int(feedPage.totalCount), count: Int(feedPage.count), offset: Int(feedPage.offset), giphy: feedPage.toLocal)
            }
        }
    }
    
    public func deleteCache() async throws {
        try await context.perform { [context] in
            try CDFeedPage.delete(in: context)
        }
    }
}
