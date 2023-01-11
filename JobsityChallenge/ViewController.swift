//
//  ViewController.swift
//  JobsityChallenge
//
//  Created by Matheus dos Reis de Jesus on 11/01/23.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        Task {
            let shows = try await ShowService(network: Network()).index()
            
            print(shows)
        }
    }


}

