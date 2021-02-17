//
//  NewsFeedViewControllerCoordinator.swift
//  newsfeed
//
//  Created by Anna Oksanichenko on 17.02.2021.
//

import UIKit

class NewsFeedViewControllerCoordinator: Coordinator {
    
    private let presenter: UINavigationController
    private var newsFeedViewController: NewsFeedViewController?
    let googleNewsAPI: GoogleNewsAPI
    var everything: GoogleNewsEverythingRequest
    
    init(presenter: UINavigationController, googleNewsAPI: GoogleNewsAPI, everything: GoogleNewsEverythingRequest) {
        self.presenter = presenter
        self.googleNewsAPI = googleNewsAPI
        self.everything = everything
    }

    
    func start() {
        // google news api
        let viewModel = NewsViewModel(googleNewsAPI: googleNewsAPI, everything: everything)
        let newsFeedViewController = NewsFeedViewController(viewModel: viewModel)
        presenter.pushViewController(newsFeedViewController, animated: true)
        self.newsFeedViewController = newsFeedViewController
    }
    
    
    
}
