//
//  Track.swift
//  RESTfulRockTracks
//
//  Created by Paul Willis on 29/08/2022.
//

import Foundation

enum WrapperType: String {
    case track
}

struct Result: Equatable {
    let wrapperType: WrapperType?
    let artistName: String
    let trackName: String
    let price: Double
    let artworkUrl: String?
}
