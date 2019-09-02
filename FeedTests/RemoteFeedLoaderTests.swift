//
//  RemoteFeedLoaderTests.swift
//  FeedTests
//
//  Created by Gustavo on 2019-09-01.
//  Copyright © 2019 Gustavo. All rights reserved.
//

import XCTest

/// The RemoteFeedLoader loads feed based on the API.
public class RemoteFeedLoader {
    
    private let client: HTTPClient
    
    init(client: HTTPClient) {
        self.client = client
    }
    
    public func load() {
        guard let url = URL(string: "http://a-url.com") else { return }
        client.get(from: url)
    }
}

/// The HTTP client protocol
protocol HTTPClient {
    /// Makes a HTTP Get requests
    ///
    /// - Parameter from: the `URL`.
    func get(from: URL)
}

class HTTPClientSpy: HTTPClient {
    var requestURL: URL?
    
    func get(from: URL) {
        requestURL = from
    }
}

class RemoteFeedLoaderTests: XCTestCase {
    func test_init_doesNotRequestDataFromURL() {
        let client = HTTPClientSpy()
        _ = RemoteFeedLoader(client: client)
        
        XCTAssertNil(client.requestURL)
    }
    
    func test_load_requestDataFromURL() {
        let client = HTTPClientSpy()
        let sut = RemoteFeedLoader(client: client)
        
        sut.load()
        
        XCTAssertNotNil(client.requestURL)
    }
}
