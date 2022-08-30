//
//  AppDependencyInjectionContainer.swift
//  RESTfulRockTracks
//
//  Created by Paul Willis on 29/08/2022.
//

import Foundation

class AppDependencyInjectionContainer {
    
    // MARK: - Network
    
    lazy var searchResultsDataTransferService: DataTransferService<SearchResultsResponseDTO> = {
        let networkRequestPerformer = NetworkRequestPerformer()
        let networkService = NetworkService(networkRequestPerformer: networkRequestPerformer)
        
        return DataTransferService<SearchResultsResponseDTO>(networkService: networkService)
    }()
    
    lazy var imageDataTransferService: DataTransferService<Data> = {
        let networkRequestPerformer = NetworkRequestPerformer()
        let networkService = NetworkService(networkRequestPerformer: networkRequestPerformer)
        
        return DataTransferService<Data>(networkService: networkService)
    }()

    
    // MARK: - DependencyInjectionContainers of Scenes
    
    func makeSearchSceneDependencyInjectionContainer() -> SearchSceneDependencyInjectionContainer {
        SearchSceneDependencyInjectionContainer(
            searchResultsDataTransferService: self.searchResultsDataTransferService,
            imageDataTransferService: self.imageDataTransferService
        )
    }
}
