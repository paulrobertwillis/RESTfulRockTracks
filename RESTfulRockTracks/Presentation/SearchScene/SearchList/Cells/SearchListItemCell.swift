//
//  SearchListItemCell.swift
//  RESTfulRockTracks
//
//  Created by Paul Willis on 29/08/2022.
//

import UIKit

class SearchListItemCell: UITableViewCell {
    
    static let reuseIdentifier = String(describing: SearchListItemCell.self)
    
    // MARK: - Outlets
    
    @IBOutlet private weak var trackNameLabel: UILabel!
    
    // MARK: - Private Properties
    
    private var viewModel: SearchListItemViewModel!
    
    func fill(with viewModel: SearchListItemViewModel) {
        self.viewModel = viewModel
        
        self.trackNameLabel.text = viewModel.trackName
    }
}
