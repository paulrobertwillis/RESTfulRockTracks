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
    
    // MARK: - DependencyInjectionContainers of Scenes
    
    func makeSearchSceneDependencyInjectionContainer() -> SearchSceneDependencyInjectionContainer {
        SearchSceneDependencyInjectionContainer(dataTransferService: self.searchResultsDataTransferService)
    }
}
