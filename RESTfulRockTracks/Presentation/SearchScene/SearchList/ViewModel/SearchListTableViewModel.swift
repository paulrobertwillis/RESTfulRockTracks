//
//  SearchListTableViewModel.swift
//  RESTfulRockTracks
//
//  Created by Paul Willis on 29/08/2022.
//

import Foundation

struct SearchListTableViewModelActions {
    let showSearchResultDetails: (SearchResult) -> Void
}

public protocol SearchListTableViewModelDelegate: AnyObject {
    func didSetSearchResults()
}

class SearchListTableViewModel {
    
    // MARK: - Private Properties
    
    private let searchResultsUseCase: SearchResultsUseCaseProtocol
    private let actions: SearchListTableViewModelActions?
    
    private var searchResultsLoadTask: URLSessionTask?
        
    // MARK: - Public Properties
    
    let screenTitle = NSLocalizedString("Rock Tracks", comment: "")

    public weak var delegate: SearchListTableViewModelDelegate?
    
    var error: String?
    
    public var searchResults: [SearchResult] = [] {
        didSet {
            self.delegate?.didSetSearchResults()
        }
    }
    
    // MARK: - Init
    
    init(useCase: SearchResultsUseCaseProtocol, actions: SearchListTableViewModelActions) {
        self.searchResultsUseCase = useCase
        self.actions = actions
    }
    
    // MARK: - API
    
    public func load() {
        self.searchResultsLoadTask = self.searchResultsUseCase.execute { result in
            switch result {
            case .success(let searchResults):
                print(searchResults)
                self.searchResults = searchResults.sortedByAscendingReleaseDate()
            case .failure(let error):
                // TODO: Use error
                self.error = error.localizedDescription
            }
            
            self.delegate?.didSetSearchResults()
        }
    }
    
    public func didSelectItem(at index: Int) {
        self.actions?.showSearchResultDetails(searchResults[index])
    }
}

private extension Array where Element == SearchResult {
    func sortedByAscendingReleaseDate() -> [SearchResult] {
        self.sorted {
            switch ($0, $1) {
            case let (a, b):
                return a.releaseDate < b.releaseDate
            }
        }
    }
}
