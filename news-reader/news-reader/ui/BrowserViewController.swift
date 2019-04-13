//
//  BrowserViewController.swift
//  news-reader
//
//  Created by Giang Pham on 13/04/2019.
//  Copyright © 2019 Giang Pham. All rights reserved.
//

import UIKit
import WebKit

class BrowserViewController: UIViewController {
    
    @IBAction func backClick(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var source: UILabel!
    var url : String!
    var sourceName : String!
    
    static func storyboardInstance() -> BrowserViewController? {
        let storyboard = UIStoryboard(name: String(describing: self), bundle: nil)
        return storyboard.instantiateInitialViewController() as? BrowserViewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        webView.load(URLRequest(url: URL(string: url)!))
        source.text = sourceName
    }

}
