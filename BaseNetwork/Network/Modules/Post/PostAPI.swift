//
//  PostAPI.swift
//  BaseNetwork
//
//  Created by Duy Truong on 11/05/2021.
//

import Foundation

class PostAPI {
    
    private let client: HTTPClient
    
    init(client: HTTPClient) {
        self.client = client
    }
    
    func getPosts(completion: @escaping (Result<[Post], Error>) -> Void) -> URLSessionDataTask {
        return client.dataTask(with: PostRequestBuilder(urlCase: .getPosts).build(),
                               completion: completion)
    }
    
    func getPost(id: Int,
                 completion: @escaping (Result<Post, Error>) -> Void) -> URLSessionDataTask {
        return client.dataTask(with: PostRequestBuilder(urlCase: .getPost(id: id)).build(),
                               completion: completion)
    }
    
    func updatePost(id: Int,
                    post: Post,
                    completion: @escaping (Result<Post, Error>) -> Void) -> URLSessionDataTask {
        return client.dataTask(with: PostRequestBuilder(urlCase: .updatePost(id: id, post: post)).build(),
                               completion: completion)
    }
    
}
