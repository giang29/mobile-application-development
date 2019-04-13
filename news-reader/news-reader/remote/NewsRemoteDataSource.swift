//
//  NewsRemoteDataSource.swift
//  news-reader
//
//  Created by Giang Pham on 12/04/2019.
//  Copyright © 2019 Giang Pham. All rights reserved.
//

import Alamofire
import Foundation
import RxSwift

enum FetchNewsFailureReason: Int, Error {
    case unAuthorized = 401
    case notFound = 404
}

//key=fe8ccfa1a1cf4ef9b9c399355ff771d3
protocol NewsRemotDataSource {
    func fetchNewsRelated(to keyword: String) -> Observable<[CommonArticle]>
    func fetchNews(from source: String) -> Observable<[CommonArticle]>
}


class NewsRemotDataSourceImpl : NewsRemotDataSource {
    func fetchNewsRelated(to keyword: String) -> Observable<[CommonArticle]> {
        return Observable.create({ (observer) -> Disposable in
            AF.request("https://newsapi.org/v2/everything?q=\(keyword)&apiKey=fe8ccfa1a1cf4ef9b9c399355ff771d3")
                .responseJSON(completionHandler: { (response) in
                    switch response.result {
                    case .success:
                        guard let data = response.data else {
                            // if no error provided by alamofire return .notFound error instead.
                            // .notFound should never happen here?
                            observer.onError(response.error ?? FetchNewsFailureReason.notFound)
                            return
                        }
                        do {
                            let result = try JSONDecoder().decode(SearchResult.self, from: data)
                            observer.onNext(result.articles)
                        } catch let error {
                            observer.onError(error)
                        }
                    case .failure(let error):
                        if let statusCode = response.response?.statusCode,
                            let reason = FetchNewsFailureReason(rawValue: statusCode) {
                            observer.onError(reason)
                        }
                        observer.onError(error)
                    }
                })
            
            return Disposables.create()
        })
    }
    func fetchNews(from source: String) -> Observable<[CommonArticle]> {
        return Observable.create({ (observer) -> Disposable in
            AF.request("https://newsapi.org/v2/everything?sources=\(source)&apiKey=fe8ccfa1a1cf4ef9b9c399355ff771d3")
                .responseJSON(completionHandler: { (response) in
                    switch response.result {
                    case .success:
                        guard let data = response.data else {
                            // if no error provided by alamofire return .notFound error instead.
                            // .notFound should never happen here?
                            observer.onError(response.error ?? FetchNewsFailureReason.notFound)
                            return
                        }
                        do {
                            let result = try JSONDecoder().decode(SearchResult.self, from: data)
                            observer.onNext(result.articles)
                        } catch let error {
                            observer.onError(error)
                        }
                    case .failure(let error):
                        if let statusCode = response.response?.statusCode,
                            let reason = FetchNewsFailureReason(rawValue: statusCode) {
                            observer.onError(reason)
                        }
                        observer.onError(error)
                    }
                })
            
            return Disposables.create()
        })
    }
}
