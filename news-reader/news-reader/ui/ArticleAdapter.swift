//
//  ArticleAdapter.swift
//  news-reader
//
//  Created by Giang Pham on 13/04/2019.
//  Copyright © 2019 Giang Pham. All rights reserved.
//

import UIKit
import AlamofireImage

class ArticleAdapter : NSObject, UITableViewDelegate, UITableViewDataSource, ButtonsDelegate {
    
    private var datasource = [CommonArticle]()
    var clickListener: ((String, String) -> Void)?
    var buttonClickListener: ((String) -> Void)?

    func newDatasource(_ datasource: [CommonArticle]) {
        self.datasource = datasource
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasource.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ArticleTableViewCell.self), for: indexPath) as? ArticleTableViewCell else {
            fatalError("The dequeued cell is not an instance of ArticleTableViewCell.")
        }
        let article = datasource[indexPath.row]
        cell.articleTitle.text = article.title
        cell.articleDescription.text = article.description
        cell.author.text = "By: \(article.author ?? "Unknown author")"
        cell.source.setTitle(article.source.name, for: .normal)
        cell.source.isHidden = article.source.id ==  nil
        if let url = article.urlToImage, let urlToImage = URL(string: url) {
            cell.articleImage.af_setImage(withURL: urlToImage, placeholderImage: UIImage(named: "placeholder"))
        } else {
            cell.articleImage.image = (UIImage(named: "placeholder"))
        }
        cell.selectionStyle = .none
        cell.delegate = self
        cell.indexPath = indexPath
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        clickListener?(datasource[indexPath.row].url, datasource[indexPath.row].source.name)
    }
    func sourceTapped(at index: IndexPath) {
        if let id = datasource[index.row].source.id {
            buttonClickListener?(id)
        }
    }
}
