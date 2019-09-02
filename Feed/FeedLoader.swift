//
//  FeedLoader.swift
//  Feed
//
//  Created by Gustavo on 2019-09-01.
//  Copyright © 2019 Gustavo. All rights reserved.
//

import Foundation

/// The load feed result representation
///
/// - sucess: The success type being returned when for success.
/// - error: The e type being returned when for success
public enum LoadFeedResult {
    case sucess([FeedItem])
    case error(Error)
}

/// The FeadLoader protocol to load the feed data
public protocol FeadLoader {
    /// Loads the feeds data.
    ///
    /// - Parameter completion: the `LoadFeedResult`.
    func load(completion: @escaping (LoadFeedResult) -> Void)
}
