//
//  HomeView.swift
//  JobsityChallenge
//
//  Created by Matheus dos Reis de Jesus on 11/01/23.
//

import Foundation
import UIKit

final class HomeView: UIView {
    
    private struct Metrics {
        static let margin: CGFloat = 16.0
        static let spacing: CGFloat = 8.0
    }
    
    lazy var showsCollectionView: UICollectionView = {
        var flowLayout = UICollectionViewFlowLayout()
        
        flowLayout.minimumInteritemSpacing = Metrics.spacing
        flowLayout.minimumLineSpacing = Metrics.spacing
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        
        collectionView.register(ShowCollectionViewCell.self, forCellWithReuseIdentifier: ShowCollectionViewCell.identifier)
        
        return collectionView
    }()
    
    init() {
        super.init(frame: .zero)
        
        setupSubviews()
        
        backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubviews() {
        addSubview(showsCollectionView)
        
        NSLayoutConstraint.activate([
            showsCollectionView.topAnchor.constraint(equalTo: topAnchor),
            showsCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Metrics.spacing),
            showsCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            showsCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Metrics.spacing)
        ])
    }
}
