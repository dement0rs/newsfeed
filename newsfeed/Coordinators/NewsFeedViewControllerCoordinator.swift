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
    private var favoritesViewControllerCoordinator: FavoritesViewControllerCoordinator?
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
    
    func newsFeedViewControllerDidSelectNews(withUrl: String, withNews: ModelForNewsCell) {
        let detailsViewControllerCoordinator  = DetailsViewControllerCoordinator(presenter: presenter, googleNewsAPI: googleNewsAPI, newsUrl: withUrl, news: withNews)
        detailsViewControllerCoordinator.start()
        self.detailsViewControllerCoordinator = detailsViewControllerCoordinator
    }
    
    func newsFeedViewControllerDidSelectFavorites() {
        let favoritesViewControllerCoordinator = FavoritesViewControllerCoordinator(presenter: presenter, googleNewsAPI: googleNewsAPI)
        favoritesViewControllerCoordinator.start()
        self.favoritesViewControllerCoordinator = favoritesViewControllerCoordinator
    }
    
    
    
    
}
