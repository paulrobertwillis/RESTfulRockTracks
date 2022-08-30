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
    @IBOutlet private weak var artistNameLabel: UILabel!
    @IBOutlet private weak var priceLabel: UILabel!
    
    // MARK: - Private Properties
    
    private var viewModel: SearchListItemViewModel!
    
    func fill(with viewModel: SearchListItemViewModel) {
        self.viewModel = viewModel
        
        self.trackNameLabel.text = viewModel.trackName
        self.artistNameLabel.text = viewModel.artistName
        self.priceLabel.text = viewModel.price
    }
}
