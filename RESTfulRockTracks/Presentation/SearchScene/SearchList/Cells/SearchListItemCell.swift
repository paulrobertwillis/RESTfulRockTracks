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
    
    @IBOutlet private weak var artworkImageView: UIImageView!
    @IBOutlet private weak var trackNameLabel: UILabel!
    @IBOutlet private weak var artistNameLabel: UILabel!
    @IBOutlet private weak var priceLabel: UILabel!
    
    // MARK: - Private Properties
    
    private var viewModel: SearchListItemViewModel!
    private var artworkImagesRepository: ImagesRepositoryProtocol?
    
    // MARK: - Setup
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 4, left: 12, bottom: 4, right: 12))
    }
    
    // MARK: - API
    
    func fill(with viewModel: SearchListItemViewModel, imagesRepository: ImagesRepositoryProtocol?) {
        self.viewModel = viewModel
        self.artworkImagesRepository = imagesRepository
        
        self.trackNameLabel.text = viewModel.trackName
        self.artistNameLabel.text = viewModel.artistName
        self.priceLabel.text = viewModel.price
        self.updateArtworkImage()
    }
    
    // MARK: - Helpers
    
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
}
