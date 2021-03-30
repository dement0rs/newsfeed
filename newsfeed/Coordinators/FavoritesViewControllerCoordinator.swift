//
//  FavoritesViewControllerCoordinator.swift
//  newsfeed
//
//  Created by Anna Oksanichenko on 24.03.2021.
//

import UIKit

class FavoritesViewControllerCoordinator: Coordinator {
    
    private let presenter: UINavigationController
    private var favoritesViewController: FavoritesViewController?
    
    init(presenter: UINavigationController) {
        self.presenter = presenter
    }
    
    
    
    func start() {
        let viewModel = FavoritesViewModel()
        let favoritesViewController = FavoritesViewController(viewModel: viewModel)
        presenter.pushViewController(favoritesViewController, animated: true)
        self.favoritesViewController = favoritesViewController
    }
    
    
}
