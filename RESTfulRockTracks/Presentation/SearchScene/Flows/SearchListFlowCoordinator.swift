//
//  SearchListFlowCoordinator.swift
//  RESTfulRockTracks
//
//  Created by Paul Willis on 29/08/2022.
//

import UIKit

protocol SearchListFlowCoordinatorDependencies {
    func makeSearchListTableViewController() -> SearchListTableViewController
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
    
    func start() {
        let viewController = self.dependencies.makeSearchListTableViewController()
        
        self.navigationController?.pushViewController(viewController, animated: false)
        self.searchListTableViewController = viewController
    }
}
