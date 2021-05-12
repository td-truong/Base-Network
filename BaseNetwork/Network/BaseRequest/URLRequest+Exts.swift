//
//  URLRequestBuilder.swift
//  BaseNetwork
//
//  Created by Duy Truong on 11/05/2021.
//

import Foundation

extension URLRequest {
    static func defaultRequest(path: String,
                               method: HTTPMethod,
                               parameters: Parameters? = nil,
                               headers: [String: String] = [:]) -> URLRequest {
        return defaultRequest(path: path,
                              method: method,
                              parameters: parameters,
                              body: nil as EmptyRequest?,
                              headers: headers)
    }
    
    static func defaultRequest<B>(path: String,
                               method: HTTPMethod,
                               parameters: Parameters? = nil,
                               body: B?,
                               headers: [String: String] = [:]) -> URLRequest where B: Encodable {
        let url = generateURL(path: path, parameters: parameters)
        var urlRequest = URLRequest(url: url)

        urlRequest.httpMethod = method.rawValue
        urlRequest.allHTTPHeaderFields = buildHeaders(with: headers)
        urlRequest.cachePolicy = .useProtocolCachePolicy
        if let body = body {
            urlRequest.httpBody = try? JSONEncoder.shared.encode(body)
        }
        return urlRequest
    }
    
    private static func generateURL(path: String, parameters: Parameters?) -> URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = Configs.host
        components.path = Configs.basePath + path
        components.queryItems = parameters?.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
        return components.url!
    }
    
    private static func buildHeaders(with extraHeaders: [String: String]) -> [String: String] {
        let defaultHeaders: [String: String] = [
            "Content-Type": "application/json",
            "Authorization": Repository.shared.accessToken
        ]
        return defaultHeaders.joined(extraHeaders)
    }
}

private extension Dictionary {
    func joined(_ other: Self) -> Self {
        var dict = self
        other.forEach { dict[$0.key] = $0.value }
        return dict
    }
}
