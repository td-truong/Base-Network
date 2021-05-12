//
//  HTTPClient.swift
//  BaseNetwork
//
//  Created by Duy Truong on 10/05/2021.
//

import Foundation

class HTTPClient {
    
    private let TAG = "[NETWORK]"
    
    private let session: URLSession
    
    init(session: URLSession) {
        self.session = session
    }
    
    func dataTask<R>(with request: URLRequest,
                     completion: @escaping (Result<R, Error>) -> Void) -> URLSessionDataTask where R: Decodable {
        let url = request.url?.absoluteString ?? ""
        Log.d(TAG, "Method:", request.httpMethod ?? "UNKNOWN", "-", url)
        Log.d(TAG, "Headers:", request.allHTTPHeaderFields ?? [:])
        
        if let body = request.httpBody {
            Log.d(TAG, "Body:", String(data: body, encoding: .utf8) ?? "")
        }
        
        let task = session.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                self.handleDataTask(url: url,
                                    data: data,
                                    response: response,
                                    error: error,
                                    completion: completion)
            }
        }
        
        task.resume()
        return task
    }
    
    private func handleDataTask<R>(url: String,
                                   data: Data?,
                                   response: URLResponse?,
                                   error: Error?,
                                   completion: @escaping (Result<R, Error>) -> Void) where R: Decodable {
        if let error = error {
            if let nsError = error as NSError?, nsError.code == URLError.Code.cancelled.rawValue {
                Log.d(TAG, "Cancelled:", url)
            } else {
                completion(.failure(error))
                Log.e(TAG, url, error)
            }
            return
        }
        
        guard let statusCode = (response as? HTTPURLResponse)?.status else {
            completion(.failure(ResponseError.noStatusCode))
            Log.e(TAG, url, String(describing: response))
            return
        }
        
        guard let data = data else {
            completion(.failure(ResponseError.noReturnData))
            Log.e(TAG, url, "- noReturnData")
            return
        }
        
        if let responseBody = String(data: data, encoding: .utf8) {
            Log.d(TAG, url, "Response body:", responseBody)
        }
        
        if statusCode == .unauthorized {
            NotificationCenter.default.post(name: Notification.Name.httpClientDidResponseUnauthorizedError,
                                            object: response,
                                            userInfo: nil)
        }
        
        switch statusCode.responseType {
        case .informational:
            break
        case .success, .redirection:
            if let emptyResponse = EmptyResponse() as? R {
                completion(.success(emptyResponse))
                return
            }
            
            do {
                let parsedObject = try JSONDecoder.shared.decode(R.self, from: data)
                completion(.success(parsedObject))
            } catch let error {
                completion(.failure(ResponseError.decodeDataFail))
                Log.e(TAG, url, "- decodeDataFail: ", error)
            }
        default:
            let responseError = ResponseErrorWithData(statusCode: statusCode, data: data)
            completion(.failure(responseError))
            Log.e(TAG, url, statusCode, String(data: data, encoding: .utf8) ?? "")
        }
    }
    
}
