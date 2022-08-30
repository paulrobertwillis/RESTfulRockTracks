//
//  ImagesRepositoryProtocol.swift
//  RESTfulRockTracks
//
//  Created by Paul on 30/08/2022.
//

import Foundation

protocol ImagesRepositoryProtocol {
    typealias ResultValue = (Result<Data, Error>)
    typealias CompletionHandler = (ResultValue) -> Void
    
    @discardableResult
    func getImage(request: URLRequest, completion: @escaping CompletionHandler) -> URLSessionTask?
}
