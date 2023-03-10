//
//  ShowView.swift
//  JobsityChallenge
//
//  Created by Matheus dos Reis de Jesus on 11/01/23.
//

import Foundation
import UIKit
import Kingfisher

protocol ShowViewDelegate: AnyObject {
    func didTapEpisodesButton()
}

final class ShowView: UIView {
    
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
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
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
        label.font = .boldSystemFont(ofSize: 32.0)
        label.textColor = .white
        label.numberOfLines = 0
        
        return label
    }()
    
    lazy var genreCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        
        flowLayout.minimumLineSpacing = Metrics.spacing
        flowLayout.minimumInteritemSpacing = Metrics.spacing
        flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.register(GenreCollectionViewCell.self, forCellWithReuseIdentifier: GenreCollectionViewCell.identifier)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.isScrollEnabled = false
        collectionView.backgroundColor = .clear
        
        return collectionView
    }()
    
    
    private lazy var summaryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        
        return label
    }()
    
    private lazy var infoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = Metrics.spacing
        
        return stackView
    }()
    
    private lazy var scheduleInfoTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 18.0)
        label.text = "Schedule"
        label.textColor = .white
        
        return label
    }()
    
    private lazy var scheduleInfoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16.0)
        label.textColor = .white.withAlphaComponent(0.6)
        label.numberOfLines = 0
        
        return label
    }()
    
    private lazy var episodesButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("List Episodes", for: .normal)
        
        button.addTarget(self, action: #selector(didTapEpisodesButton), for: .touchUpInside)
        
        return button
    }()
    
    weak var delegate: ShowViewDelegate?
    
    init() {
        super.init(frame: .zero)
        
        setupSubviews()
        
        backgroundColor = .black
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubviews() {
        addSubview(scrollView)
        
        scrollView.addSubview(contentView)
        
        contentView.addSubview(posterImageView)
        contentView.addSubview(genreCollectionView)
        contentView.addSubview(titleLabel)
        
        contentView.addSubview(infoStackView)
        
        infoStackView.addArrangedSubview(summaryLabel)
        infoStackView.addArrangedSubview(scheduleInfoTitleLabel)
        infoStackView.addArrangedSubview(scheduleInfoLabel)
        infoStackView.addArrangedSubview(episodesButton)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            posterImageView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            posterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            posterImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            posterImageView.heightAnchor.constraint(equalToConstant: Metrics.posterHeight),

            titleLabel.topAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: Metrics.spacing),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Metrics.margin),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Metrics.margin),
            
            genreCollectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Metrics.spacing),
            genreCollectionView.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -Metrics.margin),
            genreCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Metrics.margin),
            genreCollectionView.heightAnchor.constraint(greaterThanOrEqualToConstant: Metrics.genreCellHeight),
            
            infoStackView.topAnchor.constraint(equalTo: genreCollectionView.bottomAnchor, constant: Metrics.spacing),
            infoStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Metrics.margin),
            infoStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Metrics.margin),
            infoStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Metrics.margin)
        ])
    }
    
    @objc
    private func didTapEpisodesButton() {
        delegate?.didTapEpisodesButton()
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
    
    private func setupScheduleInfo(with schedule: Schedule) {
        let formatter = ListFormatter()
        formatter.locale = Locale(identifier: "en_US")
        let days = formatter.string(from: schedule.days) ?? ""
        
        scheduleInfoLabel.text = "\(days) at \(schedule.time)"
    }
    
    public func setup(with show: Show) {
        titleLabel.text = show.name
        
        setupSummaryText(with: show.summary)
        setupScheduleInfo(with: show.schedule)
        
        posterImageView.kf.setImage(with: URL(string: show.image.original)) { result in
            switch result {
            case .success:
                self.setupPosterGradient()
            default:
                return
            }
        }
        
        genreCollectionView.reloadData()
    }
}
