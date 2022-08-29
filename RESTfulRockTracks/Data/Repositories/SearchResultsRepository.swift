//
//  SearchResultsRepository.swift
//  RESTfulRockTracks
//
//  Created by Paul Willis on 29/08/2022.
//

import Foundation

class SearchResultsRepository: SearchResultsRepositoryProtocol {
    
    private let dataTransferService: DataTransferService<SearchResultsResponseDTO>
    
    init(dataTransferService: DataTransferService<SearchResultsResponseDTO>) {
        self.dataTransferService = dataTransferService
    }
    
    @discardableResult
    func getSearchResults(request: URLRequest, completion: @escaping CompletionHandler) -> URLSessionTask? {
        
        self.dataTransferService.request(request) { (result: Result<SearchResultsResponseDTO, DataTransferError>) in
            
            switch result {
            case .success(let responseDTO):
                completion(.success(responseDTO.results.map { $0.toDomain() }))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
