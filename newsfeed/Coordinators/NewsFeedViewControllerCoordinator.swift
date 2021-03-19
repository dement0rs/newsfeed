//
//  NewsFeedViewControllerCoordinator.swift
//  newsfeed
//
//  Created by Anna Oksanichenko on 17.02.2021.
//

import UIKit

class NewsFeedViewControllerCoordinator: Coordinator, NewsFeedViewControllerDelegate {
    
    
    
    private let presenter: UINavigationController
    private var newsFeedViewController: NewsFeedViewController?
    private var detailsViewControllerCoordinator: DetailsViewControllerCoordinator?
    private let googleNewsAPI: GoogleNewsAPI
    
    
    
    init(presenter: UINavigationController, googleNewsAPI: GoogleNewsAPI) {
        self.presenter = presenter
        self.googleNewsAPI = googleNewsAPI
    }

    
    func start() {
     
        let viewModel = NewsViewModel(googleNewsAPI: googleNewsAPI)
        let newsFeedViewController = NewsFeedViewController(viewModel: viewModel)
        newsFeedViewController.delegate = self
        presenter.pushViewController(newsFeedViewController, animated: true)
        self.newsFeedViewController = newsFeedViewController
    }
    
    func newsFeedViewControllerDidSelectNews(withUrl: String) {
        let detailsViewControllerCoordinator  = DetailsViewControllerCoordinator(presenter: presenter, googleNewsAPI: googleNewsAPI, newsUrl: withUrl)
        detailsViewControllerCoordinator.start()
        self.detailsViewControllerCoordinator = detailsViewControllerCoordinator
    }
    
    
    
}
