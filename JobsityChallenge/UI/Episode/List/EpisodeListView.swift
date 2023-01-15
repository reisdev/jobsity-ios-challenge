//
//  EpisodeListView.swift
//  JobsityChallenge
//
//  Created by Matheus dos Reis de Jesus on 15/01/23.
//

import Foundation
import UIKit

final class EpisodeListView: UIView {
    
    lazy var episodesTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        return tableView
    }()
    
    init() {
        super.init(frame: .zero)
        
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubviews() {
        addSubview(episodesTableView)
        
        NSLayoutConstraint.activate([
            episodesTableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            episodesTableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            episodesTableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            episodesTableView.leadingAnchor.constraint(equalTo: leadingAnchor),
        ])
    }
}
