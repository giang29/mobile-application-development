//
//  ArticleTableViewCell.swift
//  news-reader
//
//  Created by Giang Pham on 13/04/2019.
//  Copyright © 2019 Giang Pham. All rights reserved.
//

import UIKit

protocol ButtonsDelegate{
    func sourceTapped(at index:IndexPath)
}

class ArticleTableViewCell: UITableViewCell {
    var delegate: ButtonsDelegate!
    var indexPath: IndexPath!
    @IBOutlet weak var articleImage: UIImageView!
    @IBOutlet weak var articleTitle: UILabel!
    @IBOutlet weak var articleDescription: UILabel!
    @IBOutlet weak var author: UILabel!
    @IBOutlet weak var source: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func sourceTapped(_ sender: UIButton) {
        self.delegate?.sourceTapped(at: indexPath)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
