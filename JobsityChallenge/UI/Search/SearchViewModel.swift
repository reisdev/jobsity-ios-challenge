//
//  SearchViewModel.swift
//  JobsityChallenge
//
//  Created by Matheus dos Reis de Jesus on 14/01/23.
//

import Foundation

protocol SearchViewModelProtocol {
    var shows: [Show] { get }
    
    func search(for: String, completion: @escaping () -> ())
    func clearSearch(completion: @escaping () -> ())
}

final class SearchViewModel: SearchViewModelProtocol {
    
    private(set) var shows: [Show] = []
    
    private let service: SearchServiceProtocol
    
    init(service: SearchServiceProtocol) {
        self.service = service
    }
    
    func search(for term: String, completion: @escaping () -> ()) {
        Task {
            let series = try await service.series(term: term)
            
            if series.count == 0 {
                return
            }
            
            self.shows = series.map { $0.show }
            
            DispatchQueue.main.async {
                completion()
            }
        }
    }
    
    func clearSearch(completion: @escaping () -> ()) {
        self.shows = []
        
        DispatchQueue.main.async {
            completion()
        }
    }
}
