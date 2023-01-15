//
//  HomeViewModel.swift
//  JobsityChallenge
//
//  Created by Matheus dos Reis de Jesus on 14/01/23.
//

import Foundation

protocol HomeViewModelProtocol {
    var shows: [Show] { get }
    
    func fetchShows(completion: @escaping () -> ())
}

final class HomeViewModel: HomeViewModelProtocol {
    
    private(set) var shows: [Show] = []
    private var page: Int = 1
    
    private let service: ShowServiceProtocol
    
    init(service: ShowServiceProtocol) {
        self.service = service
    }
    
    func fetchShows(completion: @escaping () -> ()) {
        Task {
            var nextPage = self.page
            
            if shows.count != 0 {
                nextPage += 1
            }
            
            let shows = try await self.service.index(page: nextPage)
            
            self.shows.append(contentsOf: shows)
            self.page += 1
            
            DispatchQueue.main.async {
                completion()
            }
        }
    }
}
