//
//  SearchListTableViewController.swift
//  RESTfulRockTracks
//
//  Created by Paul Willis on 25/08/2022.
//

import UIKit

class SearchListTableViewController: UITableViewController, StoryboardInstantiable {
    
    // MARK: - Private Properties
    
    private var viewModel: SearchListTableViewModel!
    private var imagesRepository: ImagesRepositoryProtocol?
    
    // MARK: - Lifecycle
    
    static func create(with viewModel: SearchListTableViewModel,
                       imagesRepository: ImagesRepositoryProtocol?
    ) -> SearchListTableViewController {
        let view = SearchListTableViewController.instantiateViewController()
        view.viewModel = viewModel
        view.imagesRepository = imagesRepository
        return view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = self.viewModel.screenTitle
        self.setupTableView()
        self.viewModel.load()
    }
    
    private func setupTableView() {
        let cellNib = UINib(nibName: SearchListItemCell.reuseIdentifier, bundle: nil)
        self.tableView.register(cellNib, forCellReuseIdentifier: SearchListItemCell.reuseIdentifier)
    }
}

extension SearchListTableViewController: SearchListTableViewModelDelegate {
    func didSetSearchResults() {
        print(self.viewModel.searchResults)
        self.tableView.reloadData()
    }
}

extension SearchListTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.viewModel.searchResults.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = SearchListItemCell.reuseIdentifier
                
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier,
                                                                     for: indexPath) as? SearchListItemCell
        else {
            assertionFailure("Cannot dequeue reusable cell \(SearchListItemCell.self) with reuseIdentifier: \(SearchListItemCell.reuseIdentifier)")
            return UITableViewCell(style: .subtitle, reuseIdentifier: cellIdentifier)
        }
        
        let searchListItemViewModel = SearchListItemViewModel(searchResult: self.viewModel.searchResults[indexPath.row])
        
        cell.fill( with: searchListItemViewModel, imagesRepository: self.imagesRepository)
        
        return cell
    }
    
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//
//    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected row at \(indexPath)")
    }
}
