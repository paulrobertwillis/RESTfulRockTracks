//
//  SearchListViewController.swift
//  RESTfulRockTracks
//
//  Created by Paul Willis on 25/08/2022.
//

import UIKit

class SearchListViewController: UIViewController, StoryboardInstantiable {
    
    // MARK: - Private Properties
    
    private var viewModel: SearchListViewModel!
    
    // MARK: - Lifecycle
    
    static func create(with viewModel: SearchListViewModel) -> SearchListViewController {
        let view = SearchListViewController.instantiateViewController()
        view.viewModel = viewModel
        return view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = self.viewModel.screenTitle
    }
}
