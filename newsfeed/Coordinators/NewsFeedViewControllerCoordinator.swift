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
    // google news api
    
    init(presenter: UINavigationController) {
        self.presenter = presenter
    }
    
    func start() {
        // google news api
        let viewModel = NewsViewModel()
        let newsFeedViewController = NewsFeedViewController(viewModel: viewModel)
        presenter.pushViewController(newsFeedViewController, animated: true)
        self.newsFeedViewController = newsFeedViewController
    }
    
    
    
}
