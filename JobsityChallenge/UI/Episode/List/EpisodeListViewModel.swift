//
//  EpisodeListViewModel.swift
//  JobsityChallenge
//
//  Created by Matheus dos Reis de Jesus on 15/01/23.
//

import Foundation

protocol EpisodeListViewModelProtocol {
    var seasons: [Int: [Episode]] { get }
    var show: Show { get }
    
    func fetchEpisodes(completion: @escaping () -> ())
}

final class EpisodeListViewModel: EpisodeListViewModelProtocol {
    
    private let service: ShowServiceProtocol
    
    private(set) var seasons: [Int: [Episode]] = [:]
    let show: Show
    
    init(service: ShowService, show: Show) {
        self.service = service
        self.show = show
    }
    
    func fetchEpisodes(completion: @escaping () -> ()) {
        Task {
            let episodes = try await service.episodes(for: show.id)
            
            if episodes.count == 0 {
                return
            }
            
            self.seasons = Dictionary(grouping: episodes, by: { $0.season })
            
            DispatchQueue.main.async {
                completion()
            }
        }
    }
}
