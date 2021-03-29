//
//  NewsFeedViewController.swift
//  newsfeed
//
//  Created by Anna Oksanichenko on 17.02.2021.
//

import UIKit

protocol NewsFeedViewControllerDelegate: class {
    func newsFeedViewControllerDidSelectArticle(withUrl: String, withArticle: ModelForNewsCell)
    func newsFeedViewControllerDidSelectFavorites()
}

class NewsFeedViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, NewsViewModelDelegate {
    
    @IBOutlet weak var lastUpdateLAbel: UILabel!
    @IBOutlet weak var networkStatusLabel: UILabel!
    @IBOutlet weak var reconnectButton: UIButton!
    @IBOutlet weak var connectionStatusLabel: UILabel!
    @IBOutlet weak var indicatorrOfDownloading: UIActivityIndicatorView!
    @IBOutlet weak var collectionViewOfNews: UICollectionView!
    
    let newsViewModel: NewsViewModel
    let collectionViewCell = CollectionViewCell()
    weak var delegate: NewsFeedViewControllerDelegate?
    
    init(viewModel: NewsViewModel) {
        self.newsViewModel = viewModel
        super.init(nibName: "NewsFeedViewController", bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionViewOfNews.delegate = self
        collectionViewOfNews.dataSource = self
        newsViewModel.delegate = self
        
        let  nib = UINib(nibName: CollectionViewCell.reuseIdentifier, bundle: nil)
        collectionViewOfNews.register(nib, forCellWithReuseIdentifier: CollectionViewCell.reuseIdentifier)
        stateChanged(state: newsViewModel.dataState)
        self.newsViewModel.showNewsByEverythingRequest()
       
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "star.fill"), style: .plain, target: self, action: #selector(toFavoriteListClicked))
        navigationItem.rightBarButtonItem?.tintColor = .availableColor
    }
    
    @IBAction func reconnectClicked(_ sender: UIButton) {
        stateChanged(state: newsViewModel.dataState)
        newsViewModel.showNewsByEverythingRequest()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        collectionViewOfNews.collectionViewLayout.invalidateLayout()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return newsViewModel.modelsForNewsCell.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionViewOfNews.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.reuseIdentifier, for: indexPath) as! CollectionViewCell
        let cellViewModel = newsViewModel.modelsForNewsCell[indexPath.row]
        cell.fill(news: cellViewModel)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let url = newsViewModel.modelsForNewsCell[indexPath.row].url
        let article = newsViewModel.modelsForNewsCell[indexPath.row]
        delegate?.newsFeedViewControllerDidSelectArticle(withUrl: url, withArticle: article)
    }
    
}

extension NewsFeedViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let itemSizeForEachCell = newsViewModel.calculateItemSize(for: indexPath.row, in: collectionViewOfNews.frame.size)
        layout.itemSize =  itemSizeForEachCell
        return  layout.itemSize
    }
}

extension NewsFeedViewController {
    
    @objc func toFavoriteListClicked() {
        delegate?.newsFeedViewControllerDidSelectFavorites()
    }
    
    func updateDataForShowingNews() {
        collectionViewOfNews.reloadData()
    }
    
    func networkStatusDidChanged(status: Bool) {
        if status == true {
            networkStatusLabel.backgroundColor = .black
        } else {
            networkStatusLabel.backgroundColor = .red
        }
    }
    
    func setTitleForNews(newsTitle: String) {
        title = newsTitle
    }
    
    func stateChanged(state: NewsViewModel.DataAvailabilityState) {
        collectionViewOfNews.reloadData()
        switch state {
        
        case .empty:
            connectionStatusLabel.text = "Can`t get data from server, try again"
            indicatorrOfDownloading.isHidden = true
            collectionViewOfNews.isHidden = true
            reconnectButton.isHidden = false
            view.backgroundColor = .emptyColor
            
        case .loading:
            connectionStatusLabel.text = "Loading..."
            indicatorrOfDownloading.isHidden = false
            indicatorrOfDownloading.startAnimating()
            collectionViewOfNews.isHidden = true
            reconnectButton.isHidden = true
            view.backgroundColor = .loadingColor
            
        case .available:
            
            indicatorrOfDownloading.isHidden = true
            indicatorrOfDownloading.stopAnimating()
            connectionStatusLabel.isHidden = true
            collectionViewOfNews.isHidden = false
            reconnectButton.isHidden = true
            view.backgroundColor = .availableColor
            collectionViewOfNews.backgroundColor = .availableColor
            lastUpdateLAbel.text = newsViewModel.lastUpdate
        }
    }
}

extension UIColor {
    static  let availableColor = UIColor(red: 105.0/255.0, green: 130.0/255.0, blue: 220.0/255.0, alpha: 1.0)
    static  let loadingColor = UIColor(red: 125.0/255.0, green: 190.0/255.0, blue: 110.0/255.0, alpha: 1.0)
    static  let emptyColor = UIColor(red: 195.0/255.0, green: 130.0/255.0, blue: 110.0/255.0, alpha: 1.0)

}

