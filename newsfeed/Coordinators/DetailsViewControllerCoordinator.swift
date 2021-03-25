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
    private var news: ModelForNewsCell
    
    
    init(presenter: UINavigationController, googleNewsAPI: GoogleNewsAPI, newsUrl: String, news: ModelForNewsCell) {
        self.presenter = presenter
        self.googleNewsAPI = googleNewsAPI
        self.newsUrl = newsUrl
        self.news = news
    }
    
    
    
    func start() {
        let viewModel = DetailsViewModel(googleNewsAPI: googleNewsAPI, newsUrl: newsUrl, news: news)
        let detailsViewController = DetailsViewController(viewModel: viewModel)
        presenter.pushViewController(detailsViewController, animated: true)
        self.detailsViewController = detailsViewController
    }
    
    
}
