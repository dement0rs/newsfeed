//
//  NewsFeedViewController.swift
//  newsfeed
//
//  Created by Anna Oksanichenko on 17.02.2021.
//

import UIKit

class NewsFeedViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, NewsViewModelDelegate {
    
    
  
    @IBOutlet weak var lastUpdateLAbel: UILabel!
    @IBOutlet weak var networkStatusLabel: UILabel!
    @IBOutlet weak var reconnectButton: UIButton!
    @IBOutlet weak var connectionStatusLabel: UILabel!
    @IBOutlet weak var indicatorrOfDownloading: UIActivityIndicatorView!
    @IBOutlet weak var collectionViewOfNews: UICollectionView!
    
    let newsViewModel: NewsViewModel
    let collectionViewCell = CollectionViewCell()
    
    init(viewModel: NewsViewModel) {
        self.newsViewModel = viewModel
        super.init(nibName: "NewsFeedViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkInternet()
        collectionViewOfNews.delegate = self
        collectionViewOfNews.dataSource = self
        newsViewModel.delegate = self
        
        let  nib = UINib(nibName: CollectionViewCell.reuseIdentifier, bundle: nil)
        collectionViewOfNews.register(nib, forCellWithReuseIdentifier: CollectionViewCell.reuseIdentifier)
        stateChanged(state: newsViewModel.dataState)
     //   self.newsViewModel.showNewsByEverythingRequest()
        
        NotificationCenter.default
            .addObserver(self,
                         selector: #selector(statusManager),
                         name: .flagsChanged,
                         object: nil)
        reachabilityChanged()
        
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
    
}



extension NewsFeedViewController: UICollectionViewDelegateFlowLayout {
    
    func checkInternet() {
        if Network.reachability.isReachable == true {
            print("true")
            networkStatusLabel.backgroundColor = .red
            newsViewModel.isInternetOn = true
        } else {
            print("false")
            networkStatusLabel.backgroundColor = .black
            newsViewModel.isInternetOn = false
        }
        newsViewModel.behaviorOfScreenIf(networkStatus: newsViewModel.isInternetOn)
    }
    
    
    
    func reachabilityChanged() {
//        switch Network.reachability.status {
//        case .unreachable:
//            networkStatusLabel.backgroundColor = .yellow
//
//
//        case .wwan, .wifi:
//            networkStatusLabel.backgroundColor = .green
//        }
        print("Reachability Summary")
        print("Status:", Network.reachability.status)
        print("HostName:", Network.reachability.hostname ?? "nil")
        //
        print("Reachable:", Network.reachability.isReachable)
        print("Wifi:", Network.reachability.isReachableViaWiFi)
//        if Network.reachability.isReachable == false {
//            stateChanged(state: .empty)
//        }
    }
    
    @objc func statusManager(_ notification: Notification) {
        reachabilityChanged()
    }
    
    
    func stateChanged(state: NewsViewModel.DataAvailabilityState) {
        switch state {
        
        case .empty:
            self.connectionStatusLabel.text = "Can`t get data from server, try again"
            self.indicatorrOfDownloading.isHidden = true
            collectionViewOfNews.isHidden = true
            reconnectButton.isHidden = false
            view.backgroundColor = .red
            
        case .loading:
            self.connectionStatusLabel.text = "Loading..."
            self.indicatorrOfDownloading.isHidden = false
            self.indicatorrOfDownloading.startAnimating()
            self.collectionViewOfNews.isHidden = true
            reconnectButton.isHidden = true
            self.view.backgroundColor = .green
            
        case .available:
            
            self.indicatorrOfDownloading.isHidden = true
            self.indicatorrOfDownloading.stopAnimating()
            self.connectionStatusLabel.isHidden = true
            self.collectionViewOfNews.isHidden = false
            reconnectButton.isHidden = true
            self.view.backgroundColor = .blue
            collectionViewOfNews.backgroundColor = .blue
            lastUpdateLAbel.text = "Last update: \(String(describing: newsViewModel.lastUpdate?.timeAgoDisplay() ?? "some time ago"))"
            
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        
        let itemSizeForEachCell = newsViewModel.calculateItemSize(for: indexPath.row, in: collectionViewOfNews.frame.size)
        layout.itemSize =  itemSizeForEachCell
        return  layout.itemSize
        
    }
    
    func updateDataForShowingNews() {
        collectionViewOfNews.reloadData()
    }
    
}

