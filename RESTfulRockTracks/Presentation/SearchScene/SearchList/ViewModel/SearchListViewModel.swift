//
//  SearchListViewModel.swift
//  RESTfulRockTracks
//
//  Created by Paul Willis on 29/08/2022.
//

import Foundation

public protocol SearchListViewModelOutput {
    var screenTitle: String { get }
    var error: String? { get }
}

class SearchListViewModel: SearchListViewModelOutput {
    
    // MARK: - Private Properties
    
    private let searchResultsUseCase: SearchResultsUseCaseProtocol
    
    // TODO: Replace with Cancellable
    private var searchResultsLoadTask: URLSessionTask?
    
    private var searchResults: [SearchResult] = []
        
    // MARK: - Public Properties
    
    let screenTitle = NSLocalizedString("Rock Tracks", comment: "")
    var error: String?
    
    // MARK: - Init
    
    init(useCase: SearchResultsUseCaseProtocol) {
        self.searchResultsUseCase = useCase
    }
    
    // MARK: - Helpers
    
    private func load() {
        self.searchResultsLoadTask = self.searchResultsUseCase.execute { result in
            switch result {
            case .success(let searchResults):
                self.searchResults = searchResults
            case .failure(let error):
                // TODO: Specify error type
                self.error = error.localizedDescription
            }
        }
    }
}
