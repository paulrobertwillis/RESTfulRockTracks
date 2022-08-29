//
//  SearchSceneDependencyInjectionContainer.swift
//  RESTfulRockTracks
//
//  Created by Paul Willis on 29/08/2022.
//

import Foundation
import UIKit

class SearchSceneDependencyInjectionContainer {
    
    // MARK: - Private Properties
    
    private let dataTransferService: DataTransferService<SearchResultsResponseDTO>
    
    // MARK: - Init
    
    init(dataTransferService: DataTransferService<SearchResultsResponseDTO>) {
        self.dataTransferService = dataTransferService
    }
    
    // MARK: - Use Cases
    
    func makeSearchResultsUseCase() -> SearchResultsUseCase {
        SearchResultsUseCase(repository: self.makeSearchResultsRepository())
    }
    
    // MARK: - Repositories
    
    func makeSearchResultsRepository() -> SearchResultsRepository {
        SearchResultsRepository(dataTransferService: self.dataTransferService)
    }
    
    // MARK: - SearchList
    
    func makeSearchListViewController() -> SearchListViewController {
        SearchListViewController.create(with: self.makeSearchListViewModel())
    }
    
    func makeSearchListViewModel() -> SearchListViewModel {
        SearchListViewModel()
    }
    
    // MARK: - Flow Coordinators
    
    func makeSearchListFlowCoordinator(navigationController: UINavigationController) -> SearchListFlowCoordinator {
        SearchListFlowCoordinator(navigationController: navigationController, dependencies: self)
    }
}

extension SearchSceneDependencyInjectionContainer: SearchListFlowCoordinatorDependencies {}
