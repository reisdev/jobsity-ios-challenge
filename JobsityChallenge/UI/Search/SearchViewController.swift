//
//  SearchViewController.swift
//  JobsityChallenge
//
//  Created by Matheus dos Reis de Jesus on 14/01/23.
//

import Foundation
import UIKit

final class SearchViewController: UIViewController {
    
    private lazy var searchView: SearchView = {
        let view = SearchView()
        view.showsCollectionView.dataSource = self
        view.showsCollectionView.delegate = self
        
        view.searchController.searchBar.delegate = self
        
        return view
    }()
    
    private let viewModel: SearchViewModelProtocol

    init(viewModel: SearchViewModelProtocol) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = searchView
    }
    
    override func viewDidLoad() {
        title = "Search"
        
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        navigationItem.searchController = searchView.searchController
    }
    
    func search(for text: String) {
        guard text.count > 3 else { return }
        
        viewModel.search(for: text) {
            self.searchView.showsCollectionView.reloadData()
        }
    }
    
    func clearSearch() {
        viewModel.clearSearch() {
            self.searchView.showsCollectionView.reloadData()
        }
    }
}

extension SearchViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.shows.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ShowCollectionViewCell.identifier, for: indexPath) as? ShowCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let show = viewModel.shows[indexPath.row]
        
        cell.setup(with: show)
        
        return cell
    }
}

extension SearchViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout else {
            return .zero
        }
        
        let spacings = (flowLayout.minimumInteritemSpacing+collectionView.contentInset.left)
        let width = (collectionView.frame.width/2) - spacings
        
        return CGSize(width: width, height: 275)
    }
}

extension SearchViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let show = viewModel.shows[indexPath.row]
        let controller = ShowViewController(show: show)
        
        navigationController?.pushViewController(controller, animated: true)
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        search(for: searchText)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        search(for: searchBar.text ?? "")
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        clearSearch()
    }
}
