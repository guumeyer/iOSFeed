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
    private let url: URL
    
    init(url: URL, client: HTTPClient) {
        self.url = url
        self.client = client
    }
    
    public func load() {
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
        let url = URL(string: "http://a-url.com")!
        let client = HTTPClientSpy()
        _ = RemoteFeedLoader(url: url, client: client)
        
        XCTAssertNil(client.requestURL)
    }
    
    func test_load_requestDataFromURL() {
        let url = URL(string: "http://a-given-url.com")!
        let client = HTTPClientSpy()
        let sut = RemoteFeedLoader(url: url, client: client)
        
        sut.load()
        
        XCTAssertNotNil(client.requestURL)
    }
}
