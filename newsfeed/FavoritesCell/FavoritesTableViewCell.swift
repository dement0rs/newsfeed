//
//  FavoritesTableViewCell.swift
//  newsfeed
//
//  Created by Anna Oksanichenko on 24.03.2021.
//

import UIKit

class FavoritesTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    
    static let reuseIdentifier = "FavoritesTableViewCell"
    static let nibName = reuseIdentifier

    
    
    override func awakeFromNib() {
        super.awakeFromNib()


    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }
    
    func fill(news: String) {
        titleLabel.text = news
    }
}
