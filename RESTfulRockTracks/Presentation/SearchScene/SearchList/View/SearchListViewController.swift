//
//  SearchListViewController.swift
//  RESTfulRockTracks
//
//  Created by Paul Willis on 25/08/2022.
//

import UIKit

class SearchListViewController: UIViewController {
    
    // MARK: - Private Properties
    
    private let viewModel: SearchListViewModel = SearchListViewModel()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = self.viewModel.screenTitle
    }
}
