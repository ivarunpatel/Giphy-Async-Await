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
    @NSManaged public var id: String?
    @NSManaged public var title: String?
    @NSManaged public var dateTime: String?
    @NSManaged public var originalImageUrl: URL?
    @NSManaged public var originalImageWidth: String?
    @NSManaged public var originalImageHeight: String?
    @NSManaged public var smallImageUrl: URL?
    @NSManaged public var smallImageWIdth: String?
    @NSManaged public var smallImageHeight: String?
    @NSManaged public var userName: String?
    @NSManaged public var userDisplayName: String?
    @NSManaged public var page: CDFeedPage?
}
