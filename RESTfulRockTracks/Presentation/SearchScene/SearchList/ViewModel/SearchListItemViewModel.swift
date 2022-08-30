//
//  SearchListItemViewModel.swift
//  RESTfulRockTracks
//
//  Created by Paul Willis on 30/08/2022.
//

import Foundation

struct SearchListItemViewModel {
    let trackName: String
    let artistName: String
    let price: String
    let artworkImagePath: String?
}

extension SearchListItemViewModel {
    init(searchResult: SearchResult) {
        self.trackName = searchResult.trackName
        self.artistName = searchResult.artistName
        self.price = "$\(searchResult.price)"
        self.artworkImagePath = searchResult.artworkUrl
    }
}
