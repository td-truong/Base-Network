//
//  Repository.swift
//  BaseNetwork
//
//  Created by Duy Truong on 10/05/2021.
//

public class Repository {
    static let shared = Repository(client: Configs.client)
    
    private let client: HTTPClient
    
    var accessToken: String = ""
    
    init(client: HTTPClient) {
        self.client = client
    }
    
    lazy var postAPI = PostAPI(client: client)
    
}
