//
//  HeadlinesViewController.swift
//  News
//
//  Created by Wimansha Chathuranga on 11/9/19.
//  Copyright © 2019 Wimansha. All rights reserved.
//

import UIKit

class HeadlinesViewController: UIViewController {
    
    let headlinesView = NewsListView()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        self.navigationItem.title = "Top Headline News"
        configure()
        loadNews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(){
        self.view.backgroundColor = .white
        view.addSubview(headlinesView)
        headlinesView.delegate = self
        headlinesView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            headlinesView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headlinesView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headlinesView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headlinesView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            ])
        
        headlinesView.errorView.button.addTarget(self, action: #selector(loadNews), for: .touchUpInside)
        headlinesView.collectionView.refreshControl?.addTarget(self, action: #selector(loadNews), for: .valueChanged)
    }
    
    @objc func loadNews(){
        headlinesView.state = .NewsLoading
        
        NewsProvider.fetchHeadlines(completion: { (newsList : [News]?) in
            self.headlinesView.newsList = newsList!
            self.headlinesView.collectionView.reloadData()
            self.headlinesView.state = .NewsLoaded
        }) { (error : Error) in
            self.headlinesView.errorView.label.text = error.localizedDescription
            self.headlinesView.state = .LoadingFailed
        }
    }

}

extension HeadlinesViewController : NewsListViewDelegate{
    func didSelect(news: News) {
        let newsVc = NewsViewController(news: news)
        self.navigationController?.pushViewController(newsVc, animated: true)
    }
}
