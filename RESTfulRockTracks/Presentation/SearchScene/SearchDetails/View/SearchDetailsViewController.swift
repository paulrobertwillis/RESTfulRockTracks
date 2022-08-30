//
//  SearchDetailsViewController.swift
//  RESTfulRockTracks
//
//  Created by Paul on 30/08/2022.
//

import UIKit

class SearchDetailsViewController: UIViewController, StoryboardInstantiable {

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
    }
}
