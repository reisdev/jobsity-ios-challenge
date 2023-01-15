//
//  Network.swift
//  JobsityChallenge
//
//  Created by Matheus dos Reis de Jesus on 11/01/23.
//

import Foundation

protocol NetworkProtocol {
    func get<T: Decodable>(url: URL) async throws -> T
}

final class Network: NetworkProtocol {
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func get<T: Decodable>(url: URL) async throws -> T {
        do {
            var request = URLRequest(url: url)
            
            request.addValue("Bearer \(Settings.shared.apiKey)", forHTTPHeaderField: "Authorization")
            
            let (data,_) = try await session.data(for: request)
            
            let decoder = JSONDecoder()
            
            let result = try decoder.decode(T.self, from: data)
            
            return result
        } catch (let error) {
            debugPrint(error)
            throw error
        }
    }
}
