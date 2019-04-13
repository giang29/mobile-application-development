//
//  Entities.swift
//  news-reader
//
//  Created by Giang Pham on 12/04/2019.
//  Copyright © 2019 Giang Pham. All rights reserved.
//

import Foundation

struct SearchResult: Codable {
    let status: String
    let articles: [CommonArticle]
}

struct CommonArticle: Codable {
    let source: CommonSource
    let author: String?
    let title: String
    let description: String
    let url: String
    let urlToImage: String?
}

struct CommonSource: Codable {
    let id : String?
    let name : String
}
