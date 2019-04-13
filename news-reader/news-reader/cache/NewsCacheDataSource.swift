//
//  NewsCacheDataSource.swift
//  news-reader
//
//  Created by Giang Pham on 12/04/2019.
//  Copyright © 2019 Giang Pham. All rights reserved.
//

import CoreData
import Foundation
import RxSwift

protocol NewsCacheDataSource {
    func save(articles : [CommonArticle]) -> Completable
    func loadSavedArticles() -> Observable<[CacheArticle]>
}

class NewsCacheDataSourceImpl: NewsCacheDataSource {
    func save(articles: [CommonArticle]) -> Completable {
        
        return Completable.create { completable in
            articles.forEach { article in
                
                let cacheSource = self.sourceExists(name: article.source.name) ?? {
                    let source = NSEntityDescription.insertNewObject(forEntityName: "CacheSource", into: PersistanceService.context) as! CacheSource
                    source.id = article.source.id
                    source.name = article.source.name
                    return source
                }()
                
                _ = self.articleExists(url: article.url) ?? {
                    let newArticle = NSEntityDescription.insertNewObject(forEntityName: "CacheArticle", into: PersistanceService.context) as! CacheArticle
                
                    newArticle.author = article.author
                    newArticle.description_ = article.description
                    newArticle.url = article.url
                    newArticle.urlToImage = article.urlToImage
                    newArticle.title = article.title
                    newArticle.belongsTo = cacheSource
                    newArticle.createdAt = Date()
                    return newArticle
                }()
                
            }
            PersistanceService.saveContext()
            completable(.completed)
            return Disposables.create {}
        }
    }
    
    func loadSavedArticles() -> Observable<[CacheArticle]> {
        return Observable.create({ (observer) -> Disposable in
            
            let fetchRequest : NSFetchRequest<CacheArticle> = CacheArticle.fetchRequest()
            fetchRequest.sortDescriptors = [NSSortDescriptor(key: "createdAt", ascending: false)]
            fetchRequest.fetchLimit = 50
            do {
                let articles = try PersistanceService.context.fetch(fetchRequest)
                observer.onNext(articles)
            } catch {
                observer.onError(error)
            }
            return Disposables.create()
        })
    }
    
    fileprivate func sourceExists (name: String) -> CacheSource? {
        let request: NSFetchRequest<CacheSource> = CacheSource.fetchRequest()
        
        let predicate = NSPredicate(format: "name == %@", argumentArray: [name])
        
        request.predicate = predicate
        
        do {
            return try PersistanceService.context.fetch(request).first
        } catch {
            return nil
        }
    }
    
    fileprivate func articleExists (url: String) -> CacheArticle? {
        let request: NSFetchRequest<CacheArticle> = CacheArticle.fetchRequest()
        
        let predicate = NSPredicate(format: "url == %@", argumentArray: [url])
        
        request.predicate = predicate
        
        do {
            return try PersistanceService.context.fetch(request).first
        } catch {
            return nil
        }
    }
}

