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
    
    private let searchResultsDataTransferService: DataTransferService<SearchResultsResponseDTO>
    private let imageDataTransferService: DataTransferService<Data>
    
    // MARK: - Init
    
    init(
        searchResultsDataTransferService: DataTransferService<SearchResultsResponseDTO>,
        imageDataTransferService: DataTransferService<Data>
    ) {
        self.searchResultsDataTransferService = searchResultsDataTransferService
        self.imageDataTransferService = imageDataTransferService
    }
    
    // MARK: - Use Cases
    
    func makeSearchResultsUseCase() -> SearchResultsUseCase {
        SearchResultsUseCase(repository: self.makeSearchResultsRepository())
    }
    
    // MARK: - Repositories
    
    func makeSearchResultsRepository() -> SearchResultsRepository {
        SearchResultsRepository(dataTransferService: self.searchResultsDataTransferService)
    }
    
    func makeImagesRepository() -> ImagesRepository {
        ImagesRepository(dataTransferService: self.imageDataTransferService)
    }
    
    // MARK: - SearchList
    
    func makeSearchListTableViewController() -> SearchListTableViewController {
        let viewModel = self.makeSearchListTableViewModel()
        let viewController = SearchListTableViewController.create(with: viewModel, imagesRepository: self.makeImagesRepository()
        )
        viewModel.delegate = viewController
        
        return viewController
    }
    
    func makeSearchListTableViewModel() -> SearchListTableViewModel {
        SearchListTableViewModel(useCase: self.makeSearchResultsUseCase())
    }
    
    // MARK: - Flow Coordinators
    
    func makeSearchListFlowCoordinator(navigationController: UINavigationController) -> SearchListFlowCoordinator {
        SearchListFlowCoordinator(navigationController: navigationController, dependencies: self)
    }
}

extension SearchSceneDependencyInjectionContainer: SearchListFlowCoordinatorDependencies {}
