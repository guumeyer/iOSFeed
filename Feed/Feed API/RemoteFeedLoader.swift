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
        case invalidData
    }
    
    public func load( completion: @escaping (Error) -> Void)  {
        client.get(from: url) { (result) in
            switch result {
            case .success:
                completion(.invalidData)
            case .failure:
                completion(.connectivity)
            }
        }
    }
}
