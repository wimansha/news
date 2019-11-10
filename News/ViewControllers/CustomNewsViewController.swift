//
//  CustomNewsViewController.swift
//  News
//
//  Created by Wimansha Chathuranga on 11/9/19.
//  Copyright © 2019 Wimansha. All rights reserved.
//

import UIKit

class CustomNewsViewController: UIViewController {
    
    let keywordsView = KeywordSelectionView()
    let newsView = NewsListView()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        self.navigationItem.title = "Custom News"
        configure()
        loadNews()

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(){
        view.backgroundColor = .white
        
        keywordsView.delegate = self
        view.addSubview(keywordsView)
        keywordsView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(newsView)
        newsView.delegate = self
        newsView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            keywordsView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            keywordsView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            keywordsView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            keywordsView.heightAnchor.constraint(equalToConstant: 50),
            
            newsView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            newsView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            newsView.topAnchor.constraint(equalTo: keywordsView.bottomAnchor),
            newsView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            ])
        
        newsView.errorView.button.addTarget(self, action: #selector(loadNews), for: .touchUpInside)
        newsView.collectionView.refreshControl?.addTarget(self, action: #selector(loadNews), for: .valueChanged)
    }
    
    @objc func loadNews(){
        newsView.state = .NewsLoading
        
        NewsProvider.fetchNews(keyword: keywordsView.selectedKeyword, completion: { (newsList : [News]?) in
            self.newsView.newsList = newsList!
            self.newsView.collectionView.reloadData()
            self.newsView.state = .NewsLoaded
        }) { (error : Error) in
            self.newsView.errorView.label.text = error.localizedDescription
            self.newsView.state = .LoadingFailed
        }
    }
    
}

extension CustomNewsViewController : KeywordSelectionViewDelegate{
    func didSelect(keyword: String) {
        loadNews()
    }
}

extension CustomNewsViewController : NewsListViewDelegate{
    func didSelect(news: News) {
        let newsVc = NewsViewController(news: news)
        self.navigationController?.pushViewController(newsVc, animated: true)
    }
}
