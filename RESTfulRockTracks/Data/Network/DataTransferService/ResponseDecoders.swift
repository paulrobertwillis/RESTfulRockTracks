//
//  ResponseDecoder.swift
//  RESTfulRockTracks
//
//  Created by Paul Willis on 29/08/2022.
//

import Foundation

public protocol ResponseDecoder {
    func decode<T: Decodable>(_ data: Data) throws -> T
}

class JSONResponseDecoder {
    // MARK: - Private Properties
    private let jsonDecoder = JSONDecoder()
}

extension JSONResponseDecoder: ResponseDecoder {
    public func decode<T: Decodable>(_ data: Data) throws -> T {
        return try jsonDecoder.decode(T.self, from: data)
    }
}
