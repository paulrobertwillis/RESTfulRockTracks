//
//  SearchResultsRepositoryProtocol.swift
//  RESTfulRockTracks
//
//  Created by Paul Willis on 29/08/2022.
//

import Foundation

protocol SearchResultsRepositoryProtocol {
    typealias ResultValue = (Result<[SearchResult], Error>)
    typealias CompletionHandler = (ResultValue) -> Void
    
    @discardableResult
    func getSearchResults(request: URLRequest, completion: @escaping CompletionHandler) -> URLSessionTask?
}
