//
//  Repository+Post.swift
//  BaseNetwork
//
//  Created by Duy Truong on 11/05/2021.
//

import Foundation

extension Repository {
    
    @discardableResult
    func getPosts(completion: @escaping (Result<[Post], Error>) -> Void) -> URLSessionDataTask {
        return postAPI.getPosts(completion: completion)
    }
    
    @discardableResult
    func getPost(id: Int,
                 completion: @escaping (Result<Post, Error>) -> Void) -> URLSessionDataTask {
        return postAPI.getPost(id: id,
                               completion: completion)
    }
    
    @discardableResult
    func updatePost(id: Int,
                    post: Post,
                    completion: @escaping (Result<Post, Error>) -> Void) -> URLSessionDataTask {
        return postAPI.updatePost(id: id,
                                  post: post,
                                  completion: completion)
    }
    
}
