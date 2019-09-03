//
//  HTTPClient.swift
//  Feed
//
//  Created by Gustavo on 2019-09-02.
//  Copyright © 2019 Gustavo. All rights reserved.
//

import Foundation

/// The HTTP client protocol
public protocol HTTPClient {
    /// Makes a HTTP Get requests
    ///
    /// - Parameter from: the `URL`.
    func get(from url: URL, completion: @escaping (Error) -> Void) 
}
