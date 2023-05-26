//
//  ApiNetworkConfig.swift
//  GiphyAsyncAwait
//
//  Created by Varun on 26/05/23.
//

import Foundation
import NetFlow

public struct ApiNetworkConfig: NetworkConfigurable {
    public let baseURL: URL
    public let headers: [String: String]
    public let queryParameters: [String: String]
    
    public init(baseURL: URL, headers: [String: String], queryParameters: [String: String]) {
        self.baseURL = baseURL
        self.headers = headers
        self.queryParameters = queryParameters
    }
}
