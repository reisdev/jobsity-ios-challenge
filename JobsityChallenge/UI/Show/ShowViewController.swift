//
//  ShowViewController.swift
//  JobsityChallenge
//
//  Created by Matheus dos Reis de Jesus on 11/01/23.
//

import Foundation
import UIKit

final class ShowViewController: UIViewController {
    
    private lazy var showView: ShowView = {
        let showView = ShowView()
        
        return showView
    }()
    
    private let show: Show
    
    init(show: Show) {
        self.show = show
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = showView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showView.setup(with: show)
    }
}
