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
    private var detailsViewControllerCoordinator: DetailsViewControllerCoordinator?
    private let googleNewsAPI: GoogleNewsAPI
    
    
    
    init(presenter: UINavigationController, googleNewsAPI: GoogleNewsAPI) {
        self.presenter = presenter
        self.googleNewsAPI = googleNewsAPI
    }

    
    func start() {
     
        let viewModel = NewsViewModel(googleNewsAPI: googleNewsAPI)
        let newsFeedViewController = NewsFeedViewController(viewModel: viewModel)
        presenter.pushViewController(newsFeedViewController, animated: true)
        self.newsFeedViewController = newsFeedViewController
    }
    
    func toDetailsClicked() {
        let detailsViewControllerCoordinator  = DetailsViewControllerCoordinator(presenter: presenter, googleNewsAPI: googleNewsAPI)
        detailsViewControllerCoordinator.start()
        self.detailsViewControllerCoordinator = detailsViewControllerCoordinator
    }
    
    
    
}
