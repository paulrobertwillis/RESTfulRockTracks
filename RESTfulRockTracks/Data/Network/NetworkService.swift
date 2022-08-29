//
//  NetworkService.swift
//  RESTfulRockTracks
//
//  Created by Paul Willis on 29/08/2022.
//

import Foundation

enum NetworkError: Error {
    case error(statusCode: Int)
    case generic(Error)
    case someError
}

struct NetworkRequest {
    let urlRequest: URLRequest
}

struct NetworkResponse {
    let urlResponse: HTTPURLResponse
    let data: Data?
    
    init(urlResponse: HTTPURLResponse,
         data: Data? = nil) {
        self.urlResponse = urlResponse
        self.data = data
    }
}

protocol NetworkServiceProtocol {
    typealias ResultValue = (Result<Data?, NetworkError>)
    typealias CompletionHandler = (ResultValue) -> Void

    @discardableResult
    func request(request: URLRequest, completion: @escaping CompletionHandler) -> URLSessionTask?
}

class NetworkService {
    
    // MARK: - Private Properties
    
    private let networkRequestPerformer: NetworkRequestPerformerProtocol
    
    // MARK: - Lifecycle
    
    init(networkRequestPerformer: NetworkRequestPerformerProtocol) {
        self.networkRequestPerformer = networkRequestPerformer
    }
}

// MARK: - NetworkServiceProtocol

extension NetworkService: NetworkServiceProtocol {
    
    @discardableResult
    func request(request: URLRequest, completion: @escaping CompletionHandler) -> URLSessionTask? {
        
        return self.networkRequestPerformer.request(request: request) { data, response, error in
                        
            if let error = error {
                var errorToBeReturned: NetworkError
                
                if let response = response as? HTTPURLResponse {
                    errorToBeReturned = .error(statusCode: response.statusCode)
                } else {
                    errorToBeReturned = .generic(error)
                }
                
                completion (.failure(errorToBeReturned))
            } else {
                completion(.success(data))
            }
        }
    }
}
