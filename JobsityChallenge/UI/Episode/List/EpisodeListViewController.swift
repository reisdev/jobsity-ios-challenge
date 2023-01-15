//
//  EpisodeListViewController.swift
//  JobsityChallenge
//
//  Created by Matheus dos Reis de Jesus on 15/01/23.
//

import Foundation
import UIKit

final class EpisodeListViewController: UIViewController {
    
    private lazy var episodeListView: EpisodeListView = {
        let view = EpisodeListView()
        view.episodesTableView.dataSource = self
        view.episodesTableView.delegate = self
        
        return view
    }()
    
    private let viewModel: EpisodeListViewModelProtocol
    
    init(viewModel: EpisodeListViewModelProtocol) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = episodeListView
    }
    
    override func viewDidLoad() {
        title = viewModel.show.name
        
        viewModel.fetchEpisodes {
            self.episodeListView.episodesTableView.reloadData()
        }
    }
}

extension EpisodeListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.seasons.keys.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Season \(section+1)"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.seasons[section+1]?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        guard let episode = viewModel.seasons[indexPath.section+1]?[indexPath.row] else {
            return UITableViewCell()
        }
        
        var configuration = UIListContentConfiguration.subtitleCell()
        
        configuration.text = episode.name
        
        cell.contentConfiguration = configuration
        
        return cell
    }
}

extension EpisodeListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let episode = viewModel.seasons[indexPath.section+1]?[indexPath.row] else {
            return
        }
        
        let viewModel = EpisodeDetailViewModel(episode: episode)
        let controller = EpisodeDetailViewController(viewModel: viewModel)
        
        navigationController?.pushViewController(controller, animated: true)
    }
}
