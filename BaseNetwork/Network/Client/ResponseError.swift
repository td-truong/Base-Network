//
//  ResponseError.swift
//  BaseNetwork
//
//  Created by Duy Truong on 11/05/2021.
//

import Foundation

enum ResponseError: Error {
    case noStatusCode
    case noReturnData
    case decodeDataFail
    case undefined
}

struct ResponseErrorWithData: Error {
    let statusCode: HTTPStatusCode
    let data: Data
}
