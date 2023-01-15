//
//  Episode.swift
//  JobsityChallenge
//
//  Created by Matheus dos Reis de Jesus on 11/01/23.
//

import Foundation

struct Episode: Decodable {
    let name: String
    let number: Int
    let season: Int
    let summary: String?
    let image: Image?
}
