//
//  SearchDetailsViewController.swift
//  RESTfulRockTracks
//
//  Created by Paul on 30/08/2022.
//

import UIKit

class SearchDetailsViewController: UIViewController, StoryboardInstantiable {
    
    // MARK: - Outlets
    
    @IBOutlet private weak var artworkImageView: UIImageView!
    @IBOutlet private weak var trackNameLabel: UILabel!
    @IBOutlet private weak var artistNameLabel: UILabel!
    @IBOutlet private weak var priceLabel: UILabel!
    @IBOutlet private weak var durationLabel: UILabel!
    @IBOutlet private weak var releaseDateLabel: UILabel!

    // MARK: - Private Properties
    
    private var viewModel: SearchDetailsViewModel!
    
    // MARK: - Lifecycle
    
    static func create(with viewModel: SearchDetailsViewModel) -> SearchDetailsViewController {
        let view = SearchDetailsViewController.instantiateViewController()
        view.viewModel = viewModel
        return view
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpView()
        
    }
    
    // MARK: - Helpers
    
    private func setUpView() {
        self.trackNameLabel.text = self.viewModel.trackName
        self.artistNameLabel.text = self.viewModel.artistName
        self.priceLabel.text = self.viewModel.price
        self.durationLabel.text = self.viewModel.duration
        self.releaseDateLabel.text = self.viewModel.releaseDate
    }
}
