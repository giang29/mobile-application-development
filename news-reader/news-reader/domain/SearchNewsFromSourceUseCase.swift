//
//  SearchNewsFromSourceUseCase.swift
//  news-reader
//
//  Created by Giang Pham on 13/04/2019.
//  Copyright © 2019 Giang Pham. All rights reserved.
//

import Foundation
import RxSwift

class SearchNewsFromSourceUseCase {
    private let observingScheduler : SchedulerType
    private let subsribingScheduler : SchedulerType
    private let articleRepository : ArticleRepository
    
    init(
        observingScheduler : SchedulerType = MainScheduler.instance,
        subsribingScheduler : SchedulerType = ConcurrentDispatchQueueScheduler(qos: .background),
        articleRepository : ArticleRepository = ArticleRepositoryImpl()
        ) {
        self.observingScheduler = observingScheduler
        self.subsribingScheduler = subsribingScheduler
        self.articleRepository = articleRepository
    }
    
    func execute(source: String) -> Observable<[CommonArticle]> {
        return articleRepository.fetchNews(from: source)
            .subscribeOn(subsribingScheduler)
            .observeOn(observingScheduler)
    }
}
