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
        let cellsCountForHorizontalLayout: CGFloat = 3
        let cellsCountForVerticalLayout: CGFloat = 4
        let spacing: CGFloat = 17
        
        if collectionViewOfNews.frame.width < collectionViewOfNews.frame.height {
            if  indexPath.row % 7 == 0 {
                layout.itemSize = CGSize(width: totalWidth - spacing, height: totalHeight)
                return layout.itemSize
            }
            layout.itemSize = CGSize(width: (totalWidth - spacing) / cellsCountForVerticalLayout , height: totalHeight)
            return layout.itemSize
        }
        if  indexPath.row % 7 == 0 {
            layout.itemSize = CGSize(width: totalWidth - spacing, height: totalHeight)
            return layout.itemSize

        }
        layout.itemSize = CGSize(width: (totalWidth - spacing) / cellsCountForHorizontalLayout, height: totalHeight)
        return layout.itemSize
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout
                            collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func updateDataForShowingNews() {
        collectionViewOfNews.reloadData()
    }
    
}
