//
//  SearchListTableViewModel.swift
//  RESTfulRockTracks
//
//  Created by Paul Willis on 29/08/2022.
//

import Foundation

public protocol SearchListTableViewModelDelegate: AnyObject {
    func didSetSearchResults()
}

public protocol SearchListTableViewModelOutput {
    var screenTitle: String { get }
    var error: String? { get }
    var searchResults: [SearchResult] { get }
}

class SearchListTableViewModel: SearchListTableViewModelOutput {
    
    // MARK: - Private Properties
    
    private let searchResultsUseCase: SearchResultsUseCaseProtocol
    
    // TODO: Replace with Cancellable
    private var searchResultsLoadTask: URLSessionTask?
        
    // MARK: - Public Properties
    
    public weak var delegate: SearchListTableViewModelDelegate?
    
    let screenTitle = NSLocalizedString("Rock Tracks", comment: "")
    var error: String?
    
    public var searchResults: [SearchResult] = [] {
        didSet {
            self.delegate?.didSetSearchResults()
        }
    }
    
    // MARK: - Init
    
    init(useCase: SearchResultsUseCaseProtocol) {
        self.searchResultsUseCase = useCase
    }
    
    // MARK: - Helpers
    
    public func load() {
        self.searchResultsLoadTask = self.searchResultsUseCase.execute { result in
            switch result {
            case .success(let searchResults):
                self.searchResults = searchResults
            case .failure(let error):
                // TODO: Use error
                self.error = error.localizedDescription
            }
            
            self.delegate?.didSetSearchResults()
        }
    }
}
