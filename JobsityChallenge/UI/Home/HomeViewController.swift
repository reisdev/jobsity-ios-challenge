//
//  HomeViewController.swift
//  JobsityChallenge
//
//  Created by Matheus dos Reis de Jesus on 11/01/23.
//

import Foundation
import UIKit

final class HomeViewController: UIViewController {
    
    private lazy var homeView: HomeView = {
        let view = HomeView()
        
        view.showsCollectionView.delegate = self
        view.showsCollectionView.dataSource = self
        
        return view
    }()
    
    private let viewModel: HomeViewModelProtocol
    
    init(viewModel: HomeViewModelProtocol) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
        
        title = "TVMaze"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = homeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchShows()
        
        setupNavigationBar()
    }
    
    private func fetchShows() {
        viewModel.fetchShows {
            self.homeView.showsCollectionView.reloadData()
        }
    }
    
    private func setupNavigationBar() {
        let rightItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(openSearch))
        
        navigationItem.rightBarButtonItem = rightItem
        navigationItem.backButtonDisplayMode = .minimal
    }
    
    @objc
    private func openSearch() {
        let service = SearchService(network: Network())
        let viewModel = SearchViewModel(service: service)
        let controller = SearchViewController(viewModel: viewModel)
        
        navigationController?.pushViewController(controller, animated: true)
    }
}

extension HomeViewController: UICollectionViewDataSource {
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

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout else {
            return .zero
        }
        
        let spacings = (flowLayout.minimumInteritemSpacing+collectionView.contentInset.left)
        let width = (collectionView.frame.width/2) - spacings
        
        return CGSize(width: width, height: 275)
    }
}

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let show = viewModel.shows[indexPath.row]
        
        let viewModel = ShowViewModel(show: show)
        let controller = ShowViewController(viewModel: viewModel)
        
        navigationController?.pushViewController(controller, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == viewModel.shows.count-1 {
            fetchShows()
        }
    }
}
