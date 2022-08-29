//
//  TracksResponseDTO.swift
//  RESTfulRockTracks
//
//  Created by Paul Willis on 29/08/2022.
//

import Foundation

struct ResultsResponseDTO: Decodable, Equatable {
    let results: [ResultDTO]
}

extension ResultsResponseDTO {
    struct ResultDTO: Decodable, Equatable {
        let wrapperType: String
        let artistName: String
        let trackName: String
        let price: Double
        let artworkUrl100: String?
    }
}

extension ResultsResponseDTO.ResultDTO {
    func toDomain() -> SearchResult {
        return SearchResult(
            wrapperType: WrapperType(rawValue: self.wrapperType),
            artistName: self.artistName,
            trackName: self.trackName,
            price: self.price,
            artworkUrl: self.artworkUrl100
        )
    }
}
