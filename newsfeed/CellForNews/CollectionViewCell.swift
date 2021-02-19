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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    func fill(news: NewsViewModel) {
        dateLabel.text = news.modelForNewsCell.date
        autorLabel.text = news.modelForNewsCell.autor
        nameOfArticleLabel.text = news.modelForNewsCell.name
        textOfNewsLabel.text = news.modelForNewsCell.text
        sourceOfNewsLabel.text = news.modelForNewsCell.source
        
    }
}
