//
//  Show.swift
//  JobsityChallenge
//
//  Created by Matheus dos Reis de Jesus on 11/01/23.
//

import Foundation

struct Show: Decodable {
    let id: Int
    let name: String
    let genres: [String]
    let summary: String
    let schedule: Schedule
    let image: Image
}

struct Schedule: Decodable {
    let time: String
    let days: [String]
}
