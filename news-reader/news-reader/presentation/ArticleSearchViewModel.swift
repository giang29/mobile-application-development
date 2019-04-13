//
//  ArticleSearchViewModel.swift
//  news-reader
//
//  Created by Giang Pham on 13/04/2019.
//  Copyright © 2019 Giang Pham. All rights reserved.
//

import Foundation
import RxSwift

class ArticleSearchViewModel {
    private let searchNewsByKeyWordUseCase: SearchNewsByKeyWordUseCase
    private let loadSavedArticleUseCase: LoadSavedArticleUseCase
    private let searchNewsFromSourceUseCase: SearchNewsFromSourceUseCase
    private var subscriptions = [Disposable]()
    let state = LiveData<State>()
    init(
        searchNewsByKeyWordUseCase: SearchNewsByKeyWordUseCase = SearchNewsByKeyWordUseCase(),
        loadSavedArticleUseCase: LoadSavedArticleUseCase = LoadSavedArticleUseCase(),
        searchNewsFromSourceUseCase: SearchNewsFromSourceUseCase = SearchNewsFromSourceUseCase()
        ) {
        self.searchNewsByKeyWordUseCase = searchNewsByKeyWordUseCase
        self.loadSavedArticleUseCase = loadSavedArticleUseCase
        self.searchNewsFromSourceUseCase = searchNewsFromSourceUseCase
        subscriptions.append(
            loadSavedArticleUseCase.execute()
                .subscribe(
                    onNext: { [weak self] articles in
                        self?.state.value = .success(articles)
                    },
                    onError: { [weak self] err in
                        print(err.localizedDescription)
                        self?.state.value = .failed(err)
                    }
                )
        )
    }
    
    func onTextChanged(_ text: String) {
        disposeAll()
        subscriptions.append(
            searchNewsByKeyWordUseCase.execute(keyword: text)
                .subscribe(
                    onNext: { [weak self] articles in
                        self?.state.value = .success(articles)
                    }, onError: { [weak self] err in
                        print(err.localizedDescription)
                        self?.state.value = .failed(err)
                    }
                )
        )
    }
    
    func onSourceClicked(_ source: String) {
        disposeAll()
        subscriptions.append(
            searchNewsFromSourceUseCase.execute(source: source)
                .subscribe(
                    onNext: { [weak self] articles in
                        self?.state.value = .success(articles)
                    },
                    onError: { [weak self] err in
                        print(err.localizedDescription)
                        self?.state.value = .failed(err)
                    }
            )
        )
    }
    
    private func disposeAll() {
        subscriptions.forEach {
            $0.dispose()
        }
        subscriptions.removeAll()
    }
    
    deinit {
        disposeAll()
    }
}


enum State {
    case failed(Error)
    case success([CommonArticle])
}
