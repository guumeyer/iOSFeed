//
//  FeedItem.swift
//  Feed
//
//  Created by Gustavo on 2019-09-01.
//  Copyright © 2019 Gustavo. All rights reserved.
//

import Foundation

/// The FeedItem represent a feed item model.
public struct FeedItem: Equatable {
    /// The unique identification based on the UUID.
    public let id: UUID
    /// The description.
    public let description: String?
    /// The location
    public let location: String?
    /// The image URL.
    public let imageURL: URL
    
    /// Constructs a `FeedItem` object
    ///
    /// - Parameters:
    ///   - id: the unique identification
    ///   - description: the description.
    ///   - location: the location.
    ///   - imageURL: the image URL.
    public init(id: UUID, description: String?, location: String?, imageURL: URL) {
        self.id = id
        self.description = description
        self.location = location
        self.imageURL = imageURL
    }
}

// MARK: Decodable
extension FeedItem: Decodable {
    private enum CodingKeys: String, CodingKey {
        case id
        case description
        case location
        case imageURL = "image"
    }
}
