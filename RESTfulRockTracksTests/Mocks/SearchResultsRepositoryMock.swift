//
//  SearchResultsRepositoryMock.swift
//  RESTfulRockTracksTests
//
//  Created by Paul Willis on 29/08/2022.
//

import Foundation
@testable import RESTfulRockTracks

class SearchResultsRepositoryMock: SearchResultsRepositoryProtocol {
    
    // MARK: - getSearchResults
    
    var getSearchResultsCallsCount = 0
    var getSearchResultsReturnValue: URLSessionTask?
    var getSearchResultsClosure: ((CompletionHandler) -> URLSessionTask)?
    
    // request parameter
    var getSearchResultsReceivedRequest: URLRequest?
    
    // completion parameter
    var getSearchResultsCompletionReturnValue: ResultValue? = .success([])
    var getSearchResultsReceivedCompletion: CompletionHandler? = { _ in }
    
    func getSearchResults(request: URLRequest, completion: @escaping CompletionHandler) -> URLSessionTask? {
        self.getSearchResultsCallsCount += 1

        self.getSearchResultsReceivedRequest = request
        self.getSearchResultsReceivedCompletion = completion
        
        if let getSearchResultsCompletionReturnValue = self.getSearchResultsCompletionReturnValue {
            completion(getSearchResultsCompletionReturnValue)
        }
        
        return getSearchResultsClosure.map({ $0(completion) }) ?? self.getSearchResultsReturnValue
    }
}
