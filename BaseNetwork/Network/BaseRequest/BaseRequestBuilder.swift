//
//  BaseRequestBuilder.swift
//  BaseNetwork
//
//  Created by Duy Truong on 11/05/2021.
//

import Foundation

protocol BaseRequestBuilder: Any {
    associatedtype T
    
    var urlCase: T { get }
    
    func build() -> URLRequest
}
