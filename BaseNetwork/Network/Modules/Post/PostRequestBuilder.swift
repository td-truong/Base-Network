//
//  PostRequestBuilder.swift
//  BaseNetwork
//
//  Created by Duy Truong on 11/05/2021.
//

import Foundation

enum PostURLCase {
    case getPosts
    case getPost(id: Int)
    case updatePost(id: Int, post: Post)
}

struct PostRequestBuilder: BaseRequestBuilder {
    var urlCase: PostURLCase
    
    func build() -> URLRequest {
        switch urlCase {
        case .getPosts:
            return .defaultRequest(path: "/posts",
                                   method: .get)
        case .getPost(let id):
            return .defaultRequest(path: "/posts/\(id)",
                                   method: .get)
        case .updatePost(let id, let post):
            return .defaultRequest(path: "/posts/\(id)",
                                   method: .put,
                                   body: post)
        }
    }
}
