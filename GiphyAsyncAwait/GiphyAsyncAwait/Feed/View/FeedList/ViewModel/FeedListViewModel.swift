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

extension FeedListItemViewModel {
    static var dummyViewModel: FeedListItemViewModel {
        .init(feed: Feed(id: "123", title: "Happy Formula E GIF by Jaguar TCS Racing", datetime: "2023-05-11 20:31:03", images: FeedImages(original: FeedImageMetadata(height: "270", width: "480", url: URL(string: "https://media4.giphy.com/media/3evfM16yrMtQjrStbt/giphy.gif?cid=a73e0a9dc5kwahp7og6akzyhrqcuufkswvo44f0ebjdbpt8c&ep=v1_gifs_trending&rid=giphy.gif&ct=g")!), small: FeedImageMetadata(height: "200", width: "200", url: URL(string: "https://media4.giphy.com/media/DyQrKMpqkAhNHZ1iWe/200w_s.gif?cid=a73e0a9dc5kwahp7og6akzyhrqcuufkswvo44f0ebjdbpt8c&ep=v1_gifs_trending&rid=200w_s.gif&ct=g")!)), user: FeedUser(username: "chippythedog", displayName: "Chippy the Dog")))
    }
}
