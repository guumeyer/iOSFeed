//
//  HTTPClient.swift
//  Feed
//
//  Created by Gustavo on 2019-09-02.
//  Copyright © 2019 Gustavo. All rights reserved.
//

import Foundation

/// Represents the HTTPClient result
///
/// - success: the success with `HTTPURLResponse`.
/// - failure: the failure with `Error`.
public enum HTTPClientResult {
    case success(Data, HTTPURLResponse)
    case failure(Error)
}

/// The HTTP client protocol
public protocol HTTPClient {
    /// Makes a HTTP Get requests
    ///
    /// - Parameter from: the `URL`.
    func get(from url: URL, completion: @escaping (HTTPClientResult) -> Void) 
}
