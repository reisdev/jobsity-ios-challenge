//
//  ShowViewModel.swift
//  JobsityChallenge
//
//  Created by Matheus dos Reis de Jesus on 14/01/23.
//

import Foundation

protocol ShowViewModelProtocol {
    var show: Show { get }
}

final class ShowViewModel: ShowViewModelProtocol {
    
    let show: Show
    
    init(show: Show) {
        self.show = show
    }
}
