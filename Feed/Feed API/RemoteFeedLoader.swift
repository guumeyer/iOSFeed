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
    
    /// Represents the `RemoteFeedLoader`.`Error` types
    ///
    /// - connectivity: When the HTTP Request failure.
    /// - invalidData: Whe the JSON reponse is invalid data.
    public enum Error: Swift.Error {
        case connectivity
        case invalidData
    }
    
    public enum Result: Equatable {
        case success([FeedItem])
        case failure(Error)
    }
    
    public func load( completion: @escaping (Result) -> Void)  {
        client.get(from: url) { (result) in
            switch result {
            case .success:
                completion(.failure(.invalidData))
            case .failure:
                completion(.failure(.connectivity))
            }
        }
    }
}
