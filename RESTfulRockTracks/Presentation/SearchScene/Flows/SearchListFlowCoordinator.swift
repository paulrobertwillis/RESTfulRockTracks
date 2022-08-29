//
//  SearchListFlowCoordinator.swift
//  RESTfulRockTracks
//
//  Created by Paul Willis on 29/08/2022.
//

import UIKit

protocol SearchListFlowCoordinatorDependencies {
    func makeSearchListViewController() -> SearchListViewController
}

class SearchListFlowCoordinator {
    
    // MARK: - Private Properties
    
    private weak var navigationController: UINavigationController?
    private let dependencies: SearchListFlowCoordinatorDependencies
    
    private weak var searchListViewController: SearchListViewController?

    // MARK: - Init
    
    init(navigationController: UINavigationController, dependencies: SearchListFlowCoordinatorDependencies) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }
    
    func start() {
        let viewController = self.dependencies.makeSearchListViewController()
        
        self.navigationController?.pushViewController(viewController, animated: false)
        self.searchListViewController = viewController
    }
}
