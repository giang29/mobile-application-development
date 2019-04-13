//
//  LoadSavedArticleUseCase.swift
//  news-reader
//
//  Created by Giang Pham on 13/04/2019.
//  Copyright © 2019 Giang Pham. All rights reserved.
//

import Foundation
import RxSwift

class LoadSavedArticleUseCase {
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
    
    func execute() -> Observable<[CommonArticle]> {
        return articleRepository.loadSavedArticles()
            .subscribeOn(subsribingScheduler)
            .observeOn(observingScheduler)
    }
}
