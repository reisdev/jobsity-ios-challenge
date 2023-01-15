//
//  EpisodeDetailViewModel.swift
//  JobsityChallenge
//
//  Created by Matheus dos Reis de Jesus on 15/01/23.
//

import Foundation

protocol EpisodeDetailViewModelProtocol {
    var episode: Episode { get }
}

final class EpisodeDetailViewModel: EpisodeDetailViewModelProtocol {
    
    private(set) var episode: Episode
    
    init(episode: Episode) {
        self.episode = episode
    }
}
