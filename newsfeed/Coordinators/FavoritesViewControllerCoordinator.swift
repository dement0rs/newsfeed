//
//  FavoritesViewControllerCoordinator.swift
//  newsfeed
//
//  Created by Anna Oksanichenko on 24.03.2021.
//

import UIKit

class FavoritesViewControllerCoordinator: Coordinator {
    
    private let presenter: UINavigationController
    private let googleNewsAPI: GoogleNewsAPI
    private var favoritesViewController: FavoritesViewController?
    
    init(presenter: UINavigationController, googleNewsAPI: GoogleNewsAPI ) {
        self.presenter = presenter
        self.googleNewsAPI = googleNewsAPI
    }
    
    
    
    func start() {
        let viewModel = FavoritesViewModel(googleNewsAPI: googleNewsAPI)
        let favoritesViewController = FavoritesViewController(viewModel: viewModel)
        presenter.pushViewController(favoritesViewController, animated: true)
        self.favoritesViewController = favoritesViewController
    }
    
    
}
