//
//  Configs.swift
//  BaseNetwork
//
//  Created by Duy Truong on 10/05/2021.
//

import Foundation

struct Configs {
    static let host = "jsonplaceholder.typicode.com"
    static let basePath = "" // "/api/v1"
    
    static let HTTP_MAXIMUM_CONNECTIONS_PER_HOST = 15
    static let TIMEOUT_INTERVAL_FOR_REQUEST: TimeInterval = 30
    static let TIMEOUT_INTERVAL_FOR_RESOURCE: TimeInterval = 30
}

extension Configs {
    static let client: HTTPClient = {
        let configuration = URLSessionConfiguration.default
        configuration.httpMaximumConnectionsPerHost = HTTP_MAXIMUM_CONNECTIONS_PER_HOST
        configuration.timeoutIntervalForRequest = TIMEOUT_INTERVAL_FOR_REQUEST
        configuration.timeoutIntervalForResource = TIMEOUT_INTERVAL_FOR_RESOURCE
        
        let session = URLSession(configuration: configuration)
        return HTTPClient(session: session)
    }()
}
