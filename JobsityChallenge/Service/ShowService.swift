//
//  ShowService.swift
//  JobsityChallenge
//
//  Created by Matheus dos Reis de Jesus on 11/01/23.
//

import Foundation

protocol ShowServiceProtocol {
    func index(page: Int) async throws -> [Show]
    func search(for term: String) async throws -> [Show]
}

final class ShowService: ShowServiceProtocol {
    
    private let network: NetworkProtocol
    private let endpoint = "shows"
    
    private lazy var baseUrl: String = {
        return "\(Settings.shared.apiBaseUrl)/\(endpoint)"
    }()
    
    init(network: NetworkProtocol) {
        self.network = network
    }
    
    func index(page: Int = 1) async throws -> [Show] {
        guard let url = URL(string: "\(baseUrl)?page=\(page)") else { return [] }
        return try await network.get(url: url)
    }
    
    func search(for term: String) async throws -> [Show] {
        guard let url = URL(string: "\(baseUrl)?q=\(term)") else { return [] }
        return try await network.get(url: url)
    }
}
