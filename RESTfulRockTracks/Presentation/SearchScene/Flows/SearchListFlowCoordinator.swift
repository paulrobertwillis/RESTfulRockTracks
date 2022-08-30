//
//  SearchListFlowCoordinator.swift
//  RESTfulRockTracks
//
//  Created by Paul Willis on 29/08/2022.
//

import UIKit

protocol SearchListFlowCoordinatorDependencies {
    func makeSearchListTableViewController(actions: SearchListTableViewModelActions) -> SearchListTableViewController
    func makeSearchDetailsViewController(searchResult: SearchResult, actions: SearchDetailsViewModelActions) -> SearchDetailsViewController
}

class SearchListFlowCoordinator {
    
    // MARK: - Private Properties
    
    private weak var navigationController: UINavigationController?
    private let dependencies: SearchListFlowCoordinatorDependencies
    
    private weak var searchListTableViewController: SearchListTableViewController?

    // MARK: - Init
    
    init(navigationController: UINavigationController, dependencies: SearchListFlowCoordinatorDependencies) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }
    
    // MARK: - API
    
    func start() {
        let actions = SearchListTableViewModelActions(showSearchResultDetails: self.showSearchResultDetails)
        let viewController = self.dependencies.makeSearchListTableViewController(actions: actions)
        
        self.navigationController?.pushViewController(viewController, animated: false)
        self.searchListTableViewController = viewController
    }
    
    // MARK: - Actions
    
    private func showSearchResultDetails(searchResult: SearchResult) {
        let actions = SearchDetailsViewModelActions(navigateToBrowser: self.navigateToBrowser)
        let viewController = self.dependencies.makeSearchDetailsViewController(searchResult: searchResult, actions: actions)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    private func navigateToBrowser(url: URL) {
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}
