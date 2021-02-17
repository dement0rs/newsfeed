//
//  ApplicationCoordinator.swift
//  newsfeed
//
//  Created by Anna Oksanichenko on 16.02.2021.
//

import UIKit

class ApplicationCoordinator: Coordinator {
    
    let window: UIWindow
    let rootViewController: UINavigationController
    let newsFeedViewControllerCoordinator: NewsFeedViewControllerCoordinator
    //google news api
    
    init(window: UIWindow) {
        self.window = window
        rootViewController = UINavigationController()
        rootViewController.navigationBar.prefersLargeTitles = false
        newsFeedViewControllerCoordinator = NewsFeedViewControllerCoordinator(presenter: rootViewController)
        
        
    }
    
    func start() {
        window.rootViewController = rootViewController
        newsFeedViewControllerCoordinator.start()
        window.makeKeyAndVisible()
    }
    
    
    
    
    
    
    
}
