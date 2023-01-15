//
//  ShowsCollectionView.swift
//  JobsityChallenge
//
//  Created by Matheus dos Reis de Jesus on 14/01/23.
//

import Foundation
import UIKit

final class ShowsCollectionView: UICollectionView {
    
    private struct Metrics {
        static let spacing: CGFloat = 8.0
    }
    
    init(flowLayout: UICollectionViewFlowLayout) {
        super.init(frame: .zero, collectionViewLayout: flowLayout)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        
        contentInset = UIEdgeInsets(top: Metrics.spacing, left: Metrics.spacing, bottom: Metrics.spacing, right: Metrics.spacing)
        
        register(ShowCollectionViewCell.self, forCellWithReuseIdentifier: ShowCollectionViewCell.identifier)
    }
}
