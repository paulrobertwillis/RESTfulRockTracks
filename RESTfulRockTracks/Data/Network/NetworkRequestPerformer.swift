//
//  NetworkRequestPerformer.swift
//  RESTfulRockTracks
//
//  Created by Paul Willis on 29/08/2022.
//

import Foundation

protocol NetworkRequestPerformerProtocol {
    typealias CompletionHandler = (Data?, URLResponse?, Error?) -> Void
    
    func request(request: URLRequest, completion: @escaping CompletionHandler) -> URLSessionTask
}

class NetworkRequestPerformer: NetworkRequestPerformerProtocol {
    // TODO: Replace URLRequest here with NetworkRequest?
    func request(request: URLRequest, completion: @escaping CompletionHandler) -> URLSessionTask {
        
        let task = URLSession.shared.dataTask(with: request, completionHandler: completion)
        task.resume()
        return task
    }
}
