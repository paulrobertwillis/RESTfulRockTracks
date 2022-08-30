//
//  SearchDetailsViewModel.swift
//  RESTfulRockTracks
//
//  Created by Paul on 30/08/2022.
//

import Foundation

class SearchDetailsViewModel {
    
    // MARK: - Public Properties
    
    public let trackName: String
    public let artistName: String
    public let price: String
    public let duration: String
    public let releaseDate: String
    
    // MARK: - Init
    
    init(searchResult: SearchResult) {
        self.trackName = searchResult.trackName
        self.artistName = searchResult.artistName
        self.price = "$\(searchResult.price)"
        self.duration = searchResult.durationInMilliseconds.millisecondsToMinutesAndSeconds
        self.releaseDate = dateFormatter.string(from: searchResult.releaseDate!)
    }
}

private let dateFormatter: ISO8601DateFormatter = {
    let dateFormatter = ISO8601DateFormatter()
    dateFormatter.formatOptions = [
        .withFullDate
    ]
    
    return dateFormatter
}()

private extension Int {
    var millisecondsToMinutesAndSeconds: String {
        let seconds = Double(self) / 1000
        return seconds.secondsToMinutesAndSeconds
    }
}

private extension TimeInterval {
    var secondsToMinutesAndSeconds: String {
        String(format: "%dm%02ds", minute, second)
    }
    
    var minute: Int {
        Int((self/60).truncatingRemainder(dividingBy: 60))
    }
    
    var second: Int {
        Int(truncatingRemainder(dividingBy: 60).rounded())
    }
}
