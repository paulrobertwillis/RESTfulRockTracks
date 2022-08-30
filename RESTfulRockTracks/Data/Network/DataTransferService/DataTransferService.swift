//
//  DataTransferService.swift
//  RESTfulRockTracks
//
//  Created by Paul Willis on 29/08/2022.
//

import Foundation

enum DataTransferError: Error {
    case parsingFailure(Error)
    case missingData
    case decodingFailure
}

protocol DataTransferServiceProtocol {
    associatedtype GenericDecodable: Decodable
    
    typealias ResultValue = (Result<GenericDecodable, DataTransferError>)
    typealias CompletionHandler = (ResultValue) -> Void

    @discardableResult
    func request(_ request: URLRequest, completion: @escaping CompletionHandler) -> URLSessionTask?
}

class DataTransferService<GenericDecodable: Decodable>: DataTransferServiceProtocol {
    
    // MARK: - Private Properties
    
    private let networkService: NetworkServiceProtocol
    private let decoder: ResponseDecoder = JSONResponseDecoder()
    
    // MARK: - Lifecycle
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
        
    @discardableResult
    func request(_ request: URLRequest, completion: @escaping (Result<GenericDecodable, DataTransferError>) -> Void) -> URLSessionTask? {
        
        let dataSessionTask = self.networkService.request(request: request) { result in
            switch result {
            case .success(let data):
                self.handleSuccessfulRequest(for: data, completion: completion)
            case .failure(let error):
                self.resolveAndHandleError(error, completion: completion)
            }
        }
                
        return dataSessionTask
    }
    
    // MARK: - Helpers
    
    private func decode<T: Decodable>(_ data: Data?) throws -> Result<T, DataTransferError> {
        do {
            guard let data = data else { return .failure(.missingData) }
            let result: T = try self.decoder.decode(data)
            return .success(result)
        } catch {
            return .failure(.parsingFailure(error))
        }
    }
    
    private func resolve(_ error: Error) -> DataTransferError {
        return DataTransferError.parsingFailure(error)
    }
    
    private func handleSuccessfulRequest(for data: Data?, completion: CompletionHandler) {
        do {
            try self.decodeAndHandleResult(from: data, completion: completion)
        } catch(let error) {
            self.resolveAndHandleError(error, completion: completion)
        }
    }
    
    private func decodeAndHandleResult(from data: Data?, completion: CompletionHandler) throws {
        let result: ResultValue = try self.decode(data)
        completion(result)
    }
    
    private func resolveAndHandleError(_ error: Error, completion: CompletionHandler) {
        let resolvedError = self.resolve(error)
        completion(.failure(resolvedError))
    }
}
