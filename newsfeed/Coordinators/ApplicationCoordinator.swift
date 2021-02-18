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
    let googleNewsAPI: GoogleNewsAPI

    
    init(window: UIWindow, googleNewsAPI: GoogleNewsAPI) {
        self.window = window
        self.googleNewsAPI = googleNewsAPI
       
        rootViewController = UINavigationController()
        rootViewController.navigationBar.prefersLargeTitles = false
        newsFeedViewControllerCoordinator = NewsFeedViewControllerCoordinator(presenter: rootViewController, googleNewsAPI: googleNewsAPI)
        
        
    }
    
    func start() {
        window.rootViewController = rootViewController
        newsFeedViewControllerCoordinator.start()
        window.makeKeyAndVisible()
    }
    
    
    
    
    
    
    
}
