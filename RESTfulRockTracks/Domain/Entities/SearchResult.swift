//
//  SearchResult.swift
//  RESTfulRockTracks
//
//  Created by Paul Willis on 29/08/2022.
//

import Foundation

enum WrapperType: String {
    case track
}

public struct SearchResult: Equatable {
    let wrapperType: WrapperType?
    let artistName: String
    let trackName: String
    let price: Double
    let artworkUrl: String?
}
