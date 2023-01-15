//
//  EpisodeDetailView.swift
//  JobsityChallenge
//
//  Created by Matheus dos Reis de Jesus on 15/01/23.
//

import Foundation
import UIKit
import Kingfisher

final class EpisodeDetailView: UIView {
    
    private struct Metrics {
        static let posterHeight: CGFloat = 400.0
        static let spacing: CGFloat = 16.0
        static let margin: CGFloat = 24.0
        static let genreCellHeight: CGFloat = 32.0
    }
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        
        return scrollView
    }()

    private lazy var contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = Metrics.spacing
        
        return stackView
    }()
    
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
        label.font = .boldSystemFont(ofSize: 28.0)
        label.textColor = .white
        label.numberOfLines = 0
        
        return label
    }()
    
    private lazy var summaryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white.withAlphaComponent(0.6)
        label.numberOfLines = 0
        
        return label
    }()
    
    private lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white.withAlphaComponent(0.75)
        label.font = .boldSystemFont(ofSize: 20.0)
        
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
        addSubview(scrollView)
        
        scrollView.addSubview(contentStackView)
        scrollView.addSubview(posterImageView)
        
        contentStackView.addArrangedSubview(titleLabel)
        contentStackView.addArrangedSubview(infoLabel)
        contentStackView.addArrangedSubview(summaryLabel)
        
        NSLayoutConstraint.activate([
                scrollView.topAnchor.constraint(equalTo: topAnchor),
                scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
                scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
                scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
                
                posterImageView.topAnchor.constraint(equalTo: scrollView.topAnchor),
                posterImageView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
                posterImageView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
                posterImageView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
                posterImageView.heightAnchor.constraint(equalToConstant: Metrics.posterHeight),
                
                contentStackView.topAnchor.constraint(equalTo: posterImageView.bottomAnchor),
                contentStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -Metrics.margin),
                contentStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
                contentStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: Metrics.margin)
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
        
        posterImageView.layer.insertSublayer(mask, at: 0)
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
    
    func setup(with episode: Episode) {
        titleLabel.text = episode.name
        
        infoLabel.text = String(format: "S%01dE%01d", episode.season, episode.number)
        
        if let summary = episode.summary {
            setupSummaryText(with: summary)
        }
        
        if let image = episode.image {
            posterImageView.kf.setImage(with: URL(string: image.original)) { result in
                switch result {
                case .success:
                    self.setupPosterGradient()
                case .failure:
                    self.posterImageView.isHidden = true
                }
            }
        } else {
            posterImageView.isHidden = true
        }
    }
}
