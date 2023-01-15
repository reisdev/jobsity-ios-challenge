//
//  SearchView.swift
//  JobsityChallenge
//
//  Created by Matheus dos Reis de Jesus on 14/01/23.
//

import Foundation
import UIKit

final class SearchView: UIView {
    
    lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        return searchController
    }()
    
    lazy var showsCollectionView: ShowsCollectionView = {
        var flowLayout = UICollectionViewFlowLayout()
        
        flowLayout.minimumInteritemSpacing = 4.0
        flowLayout.minimumLineSpacing = 8.0
        
        let collectionView = ShowsCollectionView(flowLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        
        return collectionView
    }()
    
    init() {
        super.init(frame: .zero)
        
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubviews() {
        addSubview(showsCollectionView)
        
        NSLayoutConstraint.activate([
            showsCollectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            showsCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            showsCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            showsCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor)
        ])
    }
}
