//
//  SearchResultsUseCase.swift
//  RESTfulRockTracks
//
//  Created by Paul Willis on 29/08/2022.
//

import Foundation

protocol SearchResultsUseCaseProtocol {
    typealias ResultValue = (Result<[SearchResult], Error>)
    typealias CompletionHandler = (ResultValue) -> Void

    @discardableResult
    func execute(completion: @escaping CompletionHandler) -> URLSessionTask?
}

class SearchResultsUseCase {
    
    // MARK: - Private Properties
    
    private let repository: SearchResultsRepositoryProtocol
    
    // MARK: - Lifecycle
    
    init(repository: SearchResultsRepositoryProtocol) {
        self.repository = repository
    }
}

// MARK: - SearchResultsUseCaseProtocol

extension SearchResultsUseCase: SearchResultsUseCaseProtocol {
    @discardableResult
    func execute(completion: @escaping CompletionHandler) -> URLSessionTask? {
        let request = URLRequest(url: URL(string: "https://itunes.apple.com/search?term=rock")!)

        return self.repository.getSearchResults(request: request) { result in
            completion(result)
        }
    }
}
