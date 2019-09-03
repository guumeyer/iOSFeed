//
//  RemoteFeedLoaderTests.swift
//  FeedTests
//
//  Created by Gustavo on 2019-09-01.
//  Copyright © 2019 Gustavo. All rights reserved.
//

import XCTest
import Feed

class RemoteFeedLoaderTests: XCTestCase {
    func test_init_doesNotRequestDataFromURL() {
        let (_ , client) = makeSUT()
        
        XCTAssertTrue(client.requestURLs.isEmpty)
    }
    
    func test_load_requestsçDataFromURL() {
        let url = URL(string: "http://a-given-url.com")!
        let (sut, client) = makeSUT(url: url)
        
        sut.load { _ in }
        
        XCTAssertEqual(client.requestURLs, [url])
    }
    
    func test_loadTwice_requestsçDataFromURLTwice() {
        let url = URL(string: "http://a-given-url.com")!
        let (sut, client) = makeSUT(url: url)
        
        sut.load { _ in }
        sut.load { _ in }
        
        XCTAssertEqual(client.requestURLs, [url, url])
    }
    
    func test_load_deliversErrorOnClientError() {
        let (sut, client) = makeSUT()
        
        var captureErrors = [RemoteFeedLoader.Error]()
        sut.load { captureErrors.append($0) }
        
        let clientError = NSError(domain: "Test", code: 0)
        client.completion(with: clientError)
        
        XCTAssertEqual(captureErrors, [.connectivity])
    }
    
    func test_load_deliversErrorOnClientOnNon200HTTPResponse() {
        let (sut, client) = makeSUT()
        
        var captureErrors = [RemoteFeedLoader.Error]()
        sut.load { captureErrors.append($0) }
        
        client.completion(withStatusCode: 400)
        
        XCTAssertEqual(captureErrors, [.invalidData])
    }
    
    // MARK: - Helpers
    func makeSUT(url: URL = URL(string: "http://a-url.com")!) -> (sut: RemoteFeedLoader, client: HTTPClientSpy)  {
        let client = HTTPClientSpy()
        return (RemoteFeedLoader(url: url, client: client),  client)
    }
    
    class HTTPClientSpy: HTTPClient {
        private var messages = [(url: URL, completion: (Error?, HTTPURLResponse?) -> Void)]()
        var requestURLs: [URL] {
            return messages.map { $0.url }
        }
        
        func get(from url: URL, completion: @escaping (Error?, HTTPURLResponse?) -> Void) {
            messages.append((url, completion))
        }
        
        func completion(with error: Error, at index: Int = 0) {
            messages[index].completion(error, nil)
        }
        
        func completion(withStatusCode code: Int, at index: Int = 0) {
            let response = HTTPURLResponse(url: messages[index].url,
                                           statusCode: code,
                                           httpVersion: nil,
                                           headerFields: nil)
            messages[index].completion(nil, response)
        }
    }

}
