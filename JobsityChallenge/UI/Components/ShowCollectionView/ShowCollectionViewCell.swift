//
//  ShowCollectionViewCell.swift
//  JobsityChallenge
//
//  Created by Matheus dos Reis de Jesus on 11/01/23.
//

import Foundation
import Kingfisher
import UIKit

final class ShowCollectionViewCell: UICollectionViewCell {
    
    private lazy var nameLabel: UILabel  = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 12.0)
        label.numberOfLines = 0
        label.textColor = .white
        
        return label
    }()
    
    private lazy var posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    static var identifier = "ShowCollectionViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubviews() {
        contentView.addSubview(posterImageView)
        contentView.addSubview(nameLabel)
        
        NSLayoutConstraint.activate([
            posterImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            posterImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            posterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            posterImageView.heightAnchor.constraint(equalToConstant: 240.0),
            
            nameLabel.topAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: 8.0),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4.0),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4.0),
            nameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
    
    public func setup(with show: Show) {
        nameLabel.text = show.name
        
        posterImageView.kf.setImage(with: URL(string: show.image.medium))
    }
    
}
