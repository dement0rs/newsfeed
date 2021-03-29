//
//  DetailsViewController.swift
//  newsfeed
//
//  Created by Anna Oksanichenko on 18.03.2021.
//

import UIKit
import WebKit

class DetailsViewController: UIViewController, WKUIDelegate {
    
    let detailsViewModel: DetailsViewModel
    
    init(viewModel: DetailsViewModel) {
        self.detailsViewModel = viewModel
        super.init(nibName: "DetailsViewController", bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    var webView: WKWebView!
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.load(detailsViewModel.myRequestForShowingNews())
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "star.fill"), style: .plain, target: self, action: #selector(saveArticleClicked))
        navigationItem.rightBarButtonItem?.tintColor = .availableColor
    }
    
    @objc func saveArticleClicked() {
        detailsViewModel.saveArticle()
        
    }
    
    
    
}

