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
    
    // MARK: - Lifecycle
    
    static func create(with viewModel: SearchListTableViewModel) -> SearchListTableViewController {
        let view = SearchListTableViewController.instantiateViewController()
        view.viewModel = viewModel
        return view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = self.viewModel.screenTitle
        self.viewModel.load()
    }
}

extension SearchListTableViewController: SearchListTableViewModelDelegate {
    func didSetSearchResults() {
        print(self.viewModel.searchResults)
        self.tableView.reloadData()
        // TODO: Finish
    }
}

extension SearchListTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.viewModel.searchResults.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchListItemCell.reuseIdentifier, for: indexPath) as? SearchListItemCell else {
            assertionFailure("Cannot dequeue reusable cell \(SearchListItemCell.self) with reuseIdentifier: \(SearchListItemCell.reuseIdentifier)")
            return UITableViewCell()
        }
        
        let searchListItemViewModel = SearchListItemViewModel(searchResult: self.viewModel.searchResults[indexPath.row])
        cell.fill(with: searchListItemViewModel)
        
        return cell
    }
    
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//
//    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected row at \(indexPath)")
    }
}
