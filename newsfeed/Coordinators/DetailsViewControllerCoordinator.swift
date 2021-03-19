//
//  DetailsViewControllerCoordinator.swift
//  newsfeed
//
//  Created by Anna Oksanichenko on 18.03.2021.
//

import UIKit

class DetailsViewControllerCoordinator: Coordinator {
    
    private let presenter: UINavigationController
    private let googleNewsAPI: GoogleNewsAPI
    private var newsUrl: String
    private var detailsViewController: DetailsViewController?
    
    
    init(presenter: UINavigationController, googleNewsAPI: GoogleNewsAPI, newsUrl: String) {
        self.presenter = presenter
        self.googleNewsAPI = googleNewsAPI
        self.newsUrl = newsUrl
    }
    
    
    
    func start() {
        let viewModel = DetailsViewModel(googleNewsAPI: googleNewsAPI, newsUrl: newsUrl)
        let detailsViewController = DetailsViewController(viewModel: viewModel)
        presenter.pushViewController(detailsViewController, animated: true)
        self.detailsViewController = detailsViewController
    }
    
    
}
