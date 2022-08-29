//
//  SearchListViewModel.swift
//  RESTfulRockTracks
//
//  Created by Paul Willis on 29/08/2022.
//

import Foundation

public protocol SearchListViewModelOutput {
    var screenTitle: String { get }
}

class SearchListViewModel: SearchListViewModelOutput {
        
    // MARK: - Public Properties
    
    let screenTitle = NSLocalizedString("Rock Tracks", comment: "")
    
    
    
}
