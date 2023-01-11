//
//  ShowView.swift
//  JobsityChallenge
//
//  Created by Matheus dos Reis de Jesus on 11/01/23.
//

import Foundation
import UIKit
import Kingfisher

final class ShowView: UIView {
    
    private struct Metrics {
        static let posterHeight: CGFloat = 256.0
        static let spacing: CGFloat = 16.0
        static let margin: CGFloat = 24.0
    }
    
    private lazy var posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 32.0)
        
        return label
    }()
    
    private lazy var summaryLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white.withAlphaComponent(0.6)
        label.font = .systemFont(ofSize: 16.0)
        label.numberOfLines = 0
        
        return label
    }()
    
    init() {
        super.init(frame: .zero)
        
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubviews() {
        addSubview(posterImageView)
        addSubview(titleLabel)
        addSubview(summaryLabel)
        
        NSLayoutConstraint.activate([
            posterImageView.topAnchor.constraint(equalTo: topAnchor),
            posterImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            posterImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            posterImageView.heightAnchor.constraint(equalToConstant: Metrics.posterHeight),
            
            titleLabel.topAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: Metrics.spacing),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Metrics.margin),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Metrics.margin),
            
            summaryLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Metrics.spacing),
            summaryLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Metrics.margin),
            summaryLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Metrics.margin)
        ])
    }
    
    private func setupPosterGradient() {
        
        let mask = CAGradientLayer()
        
        mask.masksToBounds = true
        mask.frame = posterImageView.bounds
        
        let color = UIColor.black
        mask.colors = [color.withAlphaComponent(0.0).cgColor,
                       color.withAlphaComponent(0.2).cgColor,
                       color.withAlphaComponent(1.0).cgColor]
        mask.locations = [0.0, 0.7, 1.0]
        
        posterImageView.layer.addSublayer(mask)
    }
    
    private func setupSummaryText(with summary: String) {
        guard let summaryText = summary.toHtmlAttributedText() else {
            return
        }
        
        let range = NSRange(location: 0, length: summaryText.length)
        
        let color = UIColor.white.withAlphaComponent(0.6)
        
        let paragraph = NSMutableParagraphStyle()
        paragraph.alignment = .justified
        
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: color.cgColor,
            .font: UIFont.systemFont(ofSize: 16.0),
            .paragraphStyle: paragraph]
        
        summaryText.addAttributes(attributes, range: range)
        summaryLabel.attributedText = summaryText
    }
    
    public func setup(with show: Show) {
        titleLabel.text = show.name
        
        setupSummaryText(with: show.summary)
        
        posterImageView.kf.setImage(with: URL(string: show.image.original)) { _ in
            self.setupPosterGradient()
        }
    }
}
