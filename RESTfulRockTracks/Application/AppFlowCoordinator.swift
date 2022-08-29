//
//  AppFlowCoordinator.swift
//  RESTfulRockTracks
//
//  Created by Paul Willis on 29/08/2022.
//

import UIKit

class AppFlowCoordinator {
    
    // MARK: - Public Properties
    
    var navigationController: UINavigationController
    
    // MARK: - Private Properties
    
    private let appDependencyInjectionContainer: AppDependencyInjectionContainer
    
    // MARK: - Init
    
    init(navigationController: UINavigationController, appDependencyInjectionContainer: AppDependencyInjectionContainer) {
        self.navigationController = navigationController
        self.appDependencyInjectionContainer = appDependencyInjectionContainer
    }
    
    // MARK: - API
    
    func start() {
        let searchSceneDependencyInjectionContainer = self.appDependencyInjectionContainer.makeSearchSceneDependencyInjectionContainer()
        let flow = searchSceneDependencyInjectionContainer.makeSearchListFlowCoordinator(navigationController: self.navigationController)
        flow.start()
    }
}
