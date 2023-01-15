//
//  ShowViewController.swift
//  JobsityChallenge
//
//  Created by Matheus dos Reis de Jesus on 11/01/23.
//

import Foundation
import UIKit

final class ShowViewController: UIViewController {
    
    private lazy var showView: ShowView = {
        let showView = ShowView()
        showView.genreCollectionView.dataSource = self
        showView.delegate = self
        return showView
    }()
    
    private let viewModel: ShowViewModelProtocol
    
    init(viewModel: ShowViewModelProtocol) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = showView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showView.setup(with: viewModel.show)
    }
}

extension ShowViewController: ShowViewDelegate {
    func didTapEpisodesButton() {
        let service = ShowService(network: Network())
        let viewModel = EpisodeListViewModel(service: service, show: viewModel.show)
        let controller = EpisodeListViewController(viewModel: viewModel)
        navigationController?.pushViewController(controller, animated: true)
    }
}

extension ShowViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.show.genres.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GenreCollectionViewCell.identifier, for: indexPath) as? GenreCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let genre = viewModel.show.genres[indexPath.row]
        
        cell.setup(with: genre)
        
        return cell
    }
}
