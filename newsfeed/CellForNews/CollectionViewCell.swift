//
//  CollectionViewCell.swift
//  newsfeed
//
//  Created by Anna Oksanichenko on 17.02.2021.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var autorLabel: UILabel!
    @IBOutlet weak var nameOfArticleLabel: UILabel!
    @IBOutlet weak var textOfNewsLabel: UILabel!
    @IBOutlet weak var sourceOfNewsLabel: UILabel!
    
    static let reuseIdentifier = "CollectionViewCell"
    static let nibName = reuseIdentifier

    override func awakeFromNib() {
        super.awakeFromNib()
   
    }
    
    
    
    func fill(news: ModelForNewsCell) {
        dateLabel.text = news.stringDateForShowingTimeAgo
        autorLabel.text = news.autor
        nameOfArticleLabel.text = news.title
        textOfNewsLabel.text = news.content
        sourceOfNewsLabel.text = news.source
        imageView.image = UIImage(named: "picture")
        
        if let data = news.dataForImage {
            imageView.image = UIImage(data: data)
        }
        
       
    }
}
