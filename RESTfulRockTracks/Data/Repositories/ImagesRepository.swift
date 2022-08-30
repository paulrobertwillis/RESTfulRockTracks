//
//  ImagesRepository.swift
//  RESTfulRockTracks
//
//  Created by Paul on 30/08/2022.
//

import Foundation

class ImagesRepository {
    private let dataTransferService: DataTransferService<Data>
    
    init(dataTransferService: DataTransferService<Data>) {
        self.dataTransferService = dataTransferService
    }
}

extension ImagesRepository: ImagesRepositoryProtocol {
    @discardableResult
    func getImage(request: URLRequest, completion: @escaping CompletionHandler) -> URLSessionTask? {
        return self.dataTransferService.request(request) { (result: Result<Data, DataTransferError>) in
            
            let result = result.mapError { $0 as Error }
            DispatchQueue.main.async { completion(result) }
        }
    }
}
