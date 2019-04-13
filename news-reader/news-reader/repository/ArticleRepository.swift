//
//  File.swift
//  news-reader
//
//  Created by Giang Pham on 12/04/2019.
//  Copyright © 2019 Giang Pham. All rights reserved.
//
import RxSwift
import Foundation

protocol ArticleRepository {
    func fetchNewsRelated(to keyword: String) -> Observable<[CommonArticle]>
    func fetchNews(from source: String) -> Observable<[CommonArticle]>
    func loadSavedArticles() -> Observable<[CommonArticle]>
}

class ArticleRepositoryImpl: ArticleRepository {
    
    let newsRemoteDataSource: NewsRemotDataSource
    let newsCacheDataSource: NewsCacheDataSource
    
    init(newsRemoteDataSource: NewsRemotDataSource = NewsRemotDataSourceImpl(), newsCacheDataSource: NewsCacheDataSource = NewsCacheDataSourceImpl()) {
        self.newsCacheDataSource = newsCacheDataSource
        self.newsRemoteDataSource = newsRemoteDataSource
    }
    
    func fetchNewsRelated(to keyword: String) -> Observable<[CommonArticle]> {
        return newsRemoteDataSource.fetchNewsRelated(to: keyword)
            .flatMap { articles -> Observable<[CommonArticle]> in
                self.newsCacheDataSource
                    .save(articles: articles)
                    .andThen(Observable.just(articles))
        }
    }
    
    func fetchNews(from source: String) -> Observable<[CommonArticle]> {
        return newsRemoteDataSource.fetchNews(from: source)
            .flatMap { articles -> Observable<[CommonArticle]> in
                self.newsCacheDataSource
                    .save(articles: articles)
                    .andThen(Observable.just(articles))
        }
    }
    
    func loadSavedArticles() -> Observable<[CommonArticle]> {
        return newsCacheDataSource.loadSavedArticles()
            .map({ (cacheArticles) -> [CommonArticle] in
                cacheArticles.map({
                    CommonArticle(
                        source: CommonSource(id: $0.belongsTo.id, name: $0.belongsTo.name),
                        author: $0.author,
                        title: $0.title,
                        description: $0.description_,
                        url: $0.url,
                        urlToImage: $0.urlToImage
                    )
                })
            })
    }
}
