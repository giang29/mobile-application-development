//
//  ViewController.swift
//  news-reader
//
//  Created by Giang Pham on 12/04/2019.
//  Copyright © 2019 Giang Pham. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class ViewController: UIViewController {
    static func storyboardInstance() -> ViewController? {
        let storyboard = UIStoryboard(name: String(describing: self), bundle: nil)
        return storyboard.instantiateInitialViewController() as? ViewController
    }
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var tableView: UITableView!
    
    private let disposeBag = DisposeBag()
    
    private let adapter = ArticleAdapter()
    private let viewModel = ArticleSearchViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        adapter.clickListener = { url, source in
            let browserVC = BrowserViewController.storyboardInstance()
            browserVC?.url = url
            browserVC?.sourceName = source
            self.present(browserVC!, animated: true, completion: nil)
        }
        adapter.buttonClickListener = { source in
            self.viewModel.onSourceClicked(source)
        }
        tableView.delegate = adapter
        tableView.dataSource = adapter
        viewModel.state.observe { [weak self] state in
            self?.render(state)
        }
        searchBar
            .rx.text.orEmpty
            .debounce(0.5, scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] text in
                if (!text.isEmpty) {
                    self?.viewModel.onTextChanged(text)
                }
            })
            .disposed(by: disposeBag)
    }
    
    private func render(_ state: State?) {
        guard let state = state else { return }
        switch state {
        case .success(let articles):
            adapter.newDatasource(articles)
            tableView.reloadData()
        default:
            return
        }
    }
}

