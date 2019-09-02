//
//  RemoteFeedLoaderTests.swift
//  FeedTests
//
//  Created by Gustavo on 2019-09-01.
//  Copyright © 2019 Gustavo. All rights reserved.
//

import XCTest
import Feed

class HTTPClientSpy: HTTPClient {
    var requestURL: URL?
    var requestURLs = [URL]()
    func get(from: URL) {
        requestURL = from
        requestURLs.append(from)
    }
}

class RemoteFeedLoaderTests: XCTestCase {
    func test_init_doesNotRequestDataFromURL() {
        let (_ , client) = makeSUT()
        
        XCTAssertNil(client.requestURL)
    }
    
    func test_load_requestsçDataFromURL() {
        let url = URL(string: "http://a-given-url.com")!
        let (sut, client) = makeSUT(url: url)
        
        sut.load()
        
        XCTAssertNotNil(client.requestURL)
    }
    
    func test_loadTwice_requestsçDataFromURLTwice() {
        let url = URL(string: "http://a-given-url.com")!
        let (sut, client) = makeSUT(url: url)
        
        sut.load()
        sut.load()
        
        XCTAssertEqual(client.requestURLs, [url, url])
        XCTAssertEqual(client.requestURLs.count, 2)
        XCTAssertNotNil(client.requestURL)
    }
    
    func makeSUT(url: URL = URL(string: "http://a-url.com")!) -> (sut: RemoteFeedLoader, client: HTTPClientSpy)  {
        let client = HTTPClientSpy()
        return (RemoteFeedLoader(url: url, client: client),  client)
    }
}
