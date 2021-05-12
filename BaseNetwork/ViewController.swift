//
//  ViewController.swift
//  BaseNetwork
//
//  Created by Duy Truong on 10/05/2021.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        test1()
    }

    private func test1() {
        Repository.shared.getPosts { result in
            switch result {
            case .success(let posts):
                print(posts.count)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func test2() {
        Repository.shared.getPost(id: 1) { result in
            switch result {
            case .success(let post):
                print(post)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func test3() {
        let post = Post(userId: 11, title: "foo", body: "bar")
        Repository.shared.updatePost(id: 1, post: post) { result in
            switch result {
            case .success(let post):
                print(post)
            case .failure(let error):
                print(error)
            }
        }
    }

}

