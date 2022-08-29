//
//  ResponseDTOMock.swift
//  RESTfulRockTracksTests
//
//  Created by Paul Willis on 29/08/2022.
//

import Foundation

struct ResponseDTOMock: Decodable, Equatable {
    let results: [ResultDTO]
}

extension ResponseDTOMock {
    struct ResultDTO: Decodable, Equatable {
        let id: Int
        let name: String
    }
}

extension ResponseDTOMock.ResultDTO {
    func toDomain() -> DomainEntityMock {
        return DomainEntityMock(
            id: String(self.id),
            name: self.name
        )
    }
}
