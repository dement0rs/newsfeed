//
//  NewsFeedViewController.swift
//  newsfeed
//
//  Created by Anna Oksanichenko on 17.02.2021.
//

import UIKit

class NewsFeedViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, DelegateProtocol {
   
    
    @IBOutlet weak var collectionViewOfNews: UICollectionView!
    
   
    let identifier = Identifiers()
    let newsViewModel: NewsViewModel
    
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

        let  nib = UINib(nibName: "CollectionViewCell", bundle: nil)
        collectionViewOfNews.register(nib, forCellWithReuseIdentifier: identifier.identifierForCell)
        
        self.newsViewModel.test() {
            
        //    self.collectionViewOfNews.reloadData()
        }
     //  collectionViewOfNews.reloadData()
      //  print("reload data")
        print("viewdidload")
        
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        collectionViewOfNews.reloadData()
//        print("reload data viewdidappear")
//    }
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        print("viewwillappearr")
//
//    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewwillappear")
////        collectionViewOfNews.delegate = self
////        collectionViewOfNews.dataSource = self
//        newsViewModel.test()
//        collectionViewOfNews.reloadData()
    }
    func updatingData() {
        collectionViewOfNews.reloadData()
    }
    
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionViewOfNews.dequeueReusableCell(withReuseIdentifier: identifier.identifierForCell, for: indexPath) as! CollectionViewCell
        print("cell fill begin")
        cell.fill(news: newsViewModel)
        print("cell fill end")
       print("cell autor \(cell.autorLabel.text)")

        return cell
    }

}
