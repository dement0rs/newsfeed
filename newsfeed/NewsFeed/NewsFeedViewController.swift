//
//  NewsFeedViewController.swift
//  newsfeed
//
//  Created by Anna Oksanichenko on 17.02.2021.
//

import UIKit

class NewsFeedViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, NewsViewModelDelegate {
    
    
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
        
        collectionViewOfNews.delegate = self
        collectionViewOfNews.dataSource = self
        newsViewModel.delegate = self
        isLoadingInProgress(loading: newsViewModel.isIndicatorOfDownloadingHidden)

        let  nib = UINib(nibName: CollectionViewCell.reuseIdentifier, bundle: nil)
        collectionViewOfNews.register(nib, forCellWithReuseIdentifier: CollectionViewCell.reuseIdentifier)
        self.newsViewModel.showNewsByEverythingRequest()
        indicatorrOfDownloading.isHidden = newsViewModel.isIndicatorOfDownloadingHidden

        
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
    func isLoadingInProgress(loading: Bool) {
        DispatchQueue.main.async {
            self.indicatorrOfDownloading.isHidden = self.newsViewModel.isIndicatorOfDownloadingHidden
            self.indicatorrOfDownloading.isHidden ? self.indicatorrOfDownloading.stopAnimating() : self.indicatorrOfDownloading.startAnimating()
        }
        
        
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        
        let totalWidth: CGFloat = collectionViewOfNews.frame.size.width
        let totalHeight: CGFloat = 190
        let spacing: CGFloat = 35
        var currentCellWidth: CGFloat = 0
        var cellsCount : CGFloat = 2
        let countOfSpacing =  cellsCount - 1

        if collectionViewOfNews.frame.width < collectionViewOfNews.frame.height {
            if  indexPath.row % 7 == 0 {
                currentCellWidth = totalWidth - spacing
            } else {
                currentCellWidth = (totalWidth - spacing * countOfSpacing ) / cellsCount
            }
        } else {
            cellsCount = 3
            if  indexPath.row % 7 == 0 {
                currentCellWidth = totalWidth - spacing
            } else {
                currentCellWidth = (totalWidth - spacing * countOfSpacing ) / cellsCount
            }
        }
        
        layout.itemSize = CGSize(width: currentCellWidth, height: totalHeight)
        return layout.itemSize
        
    }
    
    func updateDataForShowingNews() {
        collectionViewOfNews.reloadData()
    }
    
}
