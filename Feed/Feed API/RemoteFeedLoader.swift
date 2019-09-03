//
//  RemoteFeedLoader.swift
//  Feed
//
//  Created by Gustavo on 2019-09-02.
//  Copyright © 2019 Gustavo. All rights reserved.
//

import Foundation

/// The RemoteFeedLoader loads feed based on the API.
public final class RemoteFeedLoader {
    private let url: URL
    private let client: HTTPClient
    
    public init(url: URL, client: HTTPClient) {
        self.url = url
        self.client = client
    }
    
    public enum Error: Swift.Error {
        case connectivity
    }
    
    public func load( completion: @escaping (Error) -> Void = { _ in })  {
        client.get(from: url) { error in
            completion(.connectivity)
        }
    }
}
