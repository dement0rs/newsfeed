//
//  FavoritesViewController.swift
//  newsfeed
//
//  Created by Anna Oksanichenko on 24.03.2021.
//

import UIKit

class FavoritesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var tableView: UITableView!
    let favoritesViewModel: FavoritesViewModel
    
    init(viewModel: FavoritesViewModel) {
        self.favoritesViewModel = viewModel
        super.init(nibName: "FavoritesViewController", bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()        
        
        tableView.delegate = self
        tableView.dataSource = self
        
        let  nib = UINib(nibName: FavoritesTableViewCell.reuseIdentifier, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: FavoritesTableViewCell.reuseIdentifier)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoritesViewModel.articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoritesTableViewCell.reuseIdentifier, for: indexPath) as! FavoritesTableViewCell
        let cellViewModel = favoritesViewModel.articles[indexPath.row]
        cell.fill(news: cellViewModel.title)
        return cell
    }
    
    
    
}
