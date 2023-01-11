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
    
    private var shows: [Show] = []
    private var page: Int = 1
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = homeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Task {
            do {
                let shows = try await ShowService(network: Network()).index(page: page)
                
                if shows.count > 0 {
                    self.shows = shows
                    homeView.showsCollectionView.reloadData()
                }
            } catch(let error) {
                print(error)
            }
        }
    }
}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return shows.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ShowCollectionViewCell.identifier, for: indexPath) as? ShowCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let show = shows[indexPath.row]
        
        cell.setup(with: show)
        
        return cell
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout else {
            return .zero
        }
        
        let width = (collectionView.frame.width/2) - (flowLayout.minimumInteritemSpacing*2)
        
        return CGSize(width: width, height: 275)
    }
}

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // TODO: Implement select show action
    }
}
