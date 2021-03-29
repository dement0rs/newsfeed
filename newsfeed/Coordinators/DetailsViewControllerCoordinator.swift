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
    private var detailsViewController: DetailsViewController?
    private var article: ModelForNewsCell
    
    
    init(presenter: UINavigationController, googleNewsAPI: GoogleNewsAPI, article: ModelForNewsCell) {
        self.presenter = presenter
        self.googleNewsAPI = googleNewsAPI
        self.article = article
    }
    
    
    
    func start() {
        let viewModel = DetailsViewModel(googleNewsAPI: googleNewsAPI, article: article)
        let detailsViewController = DetailsViewController(viewModel: viewModel)
        presenter.pushViewController(detailsViewController, animated: true)
        self.detailsViewController = detailsViewController
    }
    
    
}
