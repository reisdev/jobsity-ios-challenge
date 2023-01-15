//
//  GenreCollectionViewCell.swift
//  JobsityChallenge
//
//  Created by Matheus dos Reis de Jesus on 12/01/23.
//

import Foundation
import UIKit

final class GenreCollectionViewCell: UICollectionViewCell {
    
    private struct Metrics {
        static let margin: CGFloat = 8.0
    }
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.textColor = .black
        label.lineBreakMode = .byWordWrapping
        label.font = .boldSystemFont(ofSize: 12.0)
        
        return label
    }()
    
    static var identifier = "GenreCollectionViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupSubviews()
        setupStyle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
           let targetSize = CGSize(width: layoutAttributes.frame.width, height: 36)
        layoutAttributes.frame.size = contentView.systemLayoutSizeFitting(targetSize, withHorizontalFittingPriority: .fittingSizeLevel, verticalFittingPriority: .fittingSizeLevel)
           return layoutAttributes
       }

    private func setupSubviews() {
        
        contentView.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Metrics.margin),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Metrics.margin),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Metrics.margin),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Metrics.margin)
        ])
    }
    
    private func setupStyle() {
        contentView.clipsToBounds = true
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 8.0
    }
    
    public func setup(with title: String) {
        titleLabel.text = title
    }
}
