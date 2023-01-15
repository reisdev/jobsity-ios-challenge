//
//  SearchService.swift
//  JobsityChallenge
//
//  Created by Matheus dos Reis de Jesus on 14/01/23.
//

import Foundation

protocol SearchServiceProtocol {
    func series(term: String) async throws -> [Serie]
}

final class SearchService: SearchServiceProtocol {
    
    private let network: NetworkProtocol
    private let endpoint = "search"
    
    private lazy var baseUrl: String = {
        return "\(Settings.shared.apiBaseUrl)/\(endpoint)"
    }()
    
    init(network: NetworkProtocol) {
        self.network = network
    }
    
    func series(term: String) async throws -> [Serie] {
        guard let url = URL(string: "\(baseUrl)/shows?q=\(term)") else { return [] }
        return try await network.get(url: url)
    }
}
