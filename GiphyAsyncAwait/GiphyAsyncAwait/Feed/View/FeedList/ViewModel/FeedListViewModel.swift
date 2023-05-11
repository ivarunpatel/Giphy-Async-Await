//
//  FeedListViewModel.swift
//  GiphyAsyncAwait
//
//  Created by Varun on 11/05/23.
//

import Foundation

public class FeedListItemViewModel {
    public let id: String
    public let title: String
    public private(set) var trendingDateTime: String?
    public let images: FeedImages
    public private(set) var aurthorName: String?
    public var gifData: ((Data) -> Void)?
    
    public init(feed: Feed) {
        id = feed.id
        title = feed.title
        images = feed.images
        aurthorName = setAurthorName(user: feed.user)
        trendingDateTime = formatTrendingDateTime(datetime: feed.datetime)
    }
    
    private func formatTrendingDateTime(datetime: String?) -> String? {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full
        if let dateTimeString = datetime,
           let date = dateFromString(dateTime: dateTimeString) {
            let formattedDateTime = formatter.localizedString(for: date, relativeTo: Date())
            let displayDateTime = "Trending on: \(formattedDateTime)"
            return displayDateTime
        } else {
            return nil
        }
    }
    
    private func setAurthorName(user: FeedUser?) -> String? {
        if let displayName = user?.displayName {
            return "Aurthor: \(displayName)"
        } else {
            return nil
        }
    }
    
    private func dateFromString(dateTime: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd HH:mm:ss"
        return dateFormatter.date(from: dateTime)
    }
    
    public func didRequestGif() {
//        let gifURL = images.small.url
       
    }
    
    public func didCancelGifRequest() {
        gifData = nil
    }
}
