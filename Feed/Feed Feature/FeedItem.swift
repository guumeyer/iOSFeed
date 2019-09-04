//
//  FeedItem.swift
//  Feed
//
//  Created by Gustavo on 2019-09-01.
//  Copyright © 2019 Gustavo. All rights reserved.
//

import Foundation

/// The FeedItem represent a feed item model.
public struct FeedItem {
    let id: UUID
    let description: String? 
    let location: String?
    let imageURL: URL
}
