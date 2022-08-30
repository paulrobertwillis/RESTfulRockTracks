//
//  SearchResultsResponseDTO.swift
//  RESTfulRockTracks
//
//  Created by Paul Willis on 29/08/2022.
//

import Foundation

struct SearchResultsResponseDTO: Decodable, Equatable {
    let results: [SearchResultDTO]
}

extension SearchResultsResponseDTO {
    struct SearchResultDTO: Decodable, Equatable {
        let wrapperType: String
        let artistName: String
        let trackName: String
        let trackPrice: Double
        let artworkUrl100: String?
        let trackTimeMillis: Int
        let releaseDate: String
        let trackViewUrl: String
    }
}

extension SearchResultsResponseDTO.SearchResultDTO {
    func toDomain() -> SearchResult {
        return SearchResult(
            wrapperType: WrapperType(rawValue: self.wrapperType),
            artistName: self.artistName,
            trackName: self.trackName,
            price: self.trackPrice,
            artworkUrl: self.artworkUrl100,
            durationInMilliseconds: trackTimeMillis,
            // TODO: Remove force unwrapping
            releaseDate: ISO8601DateFormatter().date(from: self.releaseDate)!,
            trackViewUrl: URL(string: self.trackViewUrl)
        )
    }
}

