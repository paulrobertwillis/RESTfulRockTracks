//
//  SearchResultsRepository.swift
//  RESTfulRockTracks
//
//  Created by Paul Willis on 29/08/2022.
//

import Foundation

class SearchResultsRepository {
    
    // MARK: - Private Properties
    
    private let dataTransferService: DataTransferService<SearchResultsResponseDTO>
    
    // MARK: - Init
    
    init(dataTransferService: DataTransferService<SearchResultsResponseDTO>) {
        self.dataTransferService = dataTransferService
    }
}

extension SearchResultsRepository: SearchResultsRepositoryProtocol {
    @discardableResult
    func getSearchResults(request: URLRequest, completion: @escaping CompletionHandler) -> URLSessionTask? {
        let decoder = JSONResponseDecoder()
        
        return self.dataTransferService.request(request, decoder: decoder) { (result: Result<SearchResultsResponseDTO, DataTransferError>) in
            
            switch result {
                // TODO: Organise main.async to only be used once
            case .success(let responseDTO):
                let searchResults = responseDTO.results.map { $0.toDomain() }
                DispatchQueue.main.async {
                    completion(.success(searchResults))
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
}
