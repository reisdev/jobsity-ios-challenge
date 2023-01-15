//
//  EpisodeDetailViewController.swift
//  JobsityChallenge
//
//  Created by Matheus dos Reis de Jesus on 15/01/23.
//

import Foundation
import UIKit

final class EpisodeDetailViewController: UIViewController {
    
    private lazy var episodeView: EpisodeDetailView = {
        let view = EpisodeDetailView()
        
        return view
    }()
    
    private let viewModel: EpisodeDetailViewModelProtocol
    
    init(viewModel: EpisodeDetailViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = episodeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        episodeView.setup(with: viewModel.episode)
    }
    
}
