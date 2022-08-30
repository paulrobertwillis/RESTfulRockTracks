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
    @IBOutlet private weak var moreDetailsButton: UIButton!
    
    // MARK: - Private Properties
    
    private var viewModel: SearchDetailsViewModel!
    private var artworkImagesRepository: ImagesRepositoryProtocol?
    
    // MARK: - Lifecycle
    
    static func create(with viewModel: SearchDetailsViewModel, imagesRepository: ImagesRepositoryProtocol) -> SearchDetailsViewController {
        let view = SearchDetailsViewController.instantiateViewController()
        view.viewModel = viewModel
        view.artworkImagesRepository = imagesRepository
        return view
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpView()
        self.setUpButton()
        self.updateArtworkImage()
    }
    
    // MARK: - Setup
    
    private func setUpView() {
        self.trackNameLabel.text = self.viewModel.trackName
        self.artistNameLabel.text = self.viewModel.artistName
        self.priceLabel.text = self.viewModel.price
        self.durationLabel.text = self.viewModel.duration
        self.releaseDateLabel.text = self.viewModel.releaseDate
    }
    
    private func setUpButton() {
        self.moreDetailsButton.layer.cornerRadius = 10
    }
    
    private func updateArtworkImage() {
        self.artworkImageView.image = nil
        guard let artworkImagePath = self.viewModel.artworkImagePath,
              let url = URL(string: artworkImagePath)
        else {
            return
        }
        
        let urlRequest = URLRequest(url: url)
                
        self.artworkImagesRepository?.getImage(request: urlRequest) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let data):
                self.artworkImageView.image = UIImage(data: data)
            case .failure(_):
                self.artworkImageView.image = UIImage(named: "PlaceholderArtworkImage")
            }
        }
    }
    
    // MARK: - IBActions
    
    @IBAction func didTapMoreDetailsButton(_ sender: UIButton) {
        self.viewModel.didTapMoreDetailsButton()
    }
}
