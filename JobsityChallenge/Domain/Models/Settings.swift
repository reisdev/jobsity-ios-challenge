//
//  Settings.swift
//  JobsityChallenge
//
//  Created by Matheus dos Reis de Jesus on 11/01/23.
//

import Foundation

final class Settings {
    static var shared: Settings = {
        return Settings()
    }()
    
    lazy var credentials: NSDictionary = {
        guard let fileUrl = Bundle.main.url(forResource: "TVMaze", withExtension: "plist") else {
          fatalError("Couldn't find file 'TVMaze.plist'.")
        }
        
        guard let data = try? Data(contentsOf: fileUrl) else {
            fatalError("Can't parse 'TVMaze.plist'.")
        }
        
        return try! PropertyListSerialization.propertyList(from: data, format: nil) as! NSDictionary
    }()
    
    lazy var apiBaseUrl: String = {
        return credentials.object(forKey: "API_URL") as? String ?? ""
    }()
    
    lazy var apiKey: String = {
        return credentials.object(forKey: "API_KEY") as? String ?? ""
    }()
}
