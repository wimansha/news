//
//  NewsListView.swift
//  News
//
//  Created by Wimansha Chathuranga on 11/9/19.
//  Copyright © 2019 Wimansha. All rights reserved.
//

import UIKit

protocol NewsListViewDelegate {
    func didSelect(news: News)
}

class NewsListView: UIView, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    enum State {
        case NewsLoading
        case NewsLoaded
        case LoadingFailed
    }
    
    var _columnCount: Int!
    var _rowCount: Float!
    var _cellSpace: CGFloat!
    
    var delegate : NewsListViewDelegate?
    
    var newsList = [News]()
    
    let errorView = ErrorView()
    
    var state : State = .NewsLoading{
        didSet{
            if state == .NewsLoading{
                collectionView.refreshControl?.beginRefreshing()
                collectionView.isHidden = false
                errorView.isHidden = true
            }else if state == .NewsLoaded{
                collectionView.refreshControl?.endRefreshing()
                collectionView.isHidden = false
                errorView.isHidden = true
            }else if state == .LoadingFailed{
                collectionView.refreshControl?.endRefreshing()
                collectionView.isHidden = true
                errorView.isHidden = false
                
            }
        }
    }
    
    init() {
        super.init(frame: CGRect.zero)
        _columnCount = 1
        _rowCount = 5.5
        _cellSpace = 10
        configureUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var collectionView : UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumInteritemSpacing = _cellSpace
        flowLayout.minimumLineSpacing = _cellSpace
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: flowLayout)
        collectionView.isPrefetchingEnabled = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.allowsSelection = true
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.contentInset = UIEdgeInsets(top: _cellSpace, left: _cellSpace, bottom: _cellSpace, right: _cellSpace)
        return collectionView
    }()
    
    func configureUI(){
        
        collectionView.register(NewsCell.self, forCellWithReuseIdentifier: NewsCell.identifier)
        collectionView.backgroundColor = UIColor.clear
        self.addSubview(collectionView)
        
        var views : [String:Any] = ["collectionView":collectionView]
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[collectionView]-0-|", options: [], metrics: nil, views: views))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[collectionView]-0-|", options: [], metrics: nil, views: views))
        
        //--
        
        self.addSubview(errorView)
        errorView.translatesAutoresizingMaskIntoConstraints = false
        views = ["errorView":errorView]
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[errorView]-0-|", options: [], metrics: nil, views: views))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[errorView]-0-|", options: [], metrics: nil, views: views))
        
        //--
        
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .gray
        collectionView.refreshControl = refreshControl
        

    }
    
    //MARK:- UICollectionViewDataSource methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return newsList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewsCell.identifier, for: indexPath) as? NewsCell
        cell?.set(news: newsList[indexPath.item])
        return cell!
    }
    
    //MARK:- UICollectionViewDelegateFlowLayout delegate methods
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var width, height: CGFloat!
        width = (collectionView.frame.size.width - (_cellSpace*CGFloat(_columnCount+1)))/CGFloat(_columnCount);
        height = (collectionView.frame.size.height - (_cellSpace*CGFloat(_rowCount+1)))/CGFloat(_rowCount)
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedNews = newsList[indexPath.item]
        delegate?.didSelect(news: selectedNews)
    }
    
}

class ErrorView : UIView{
    let label = UILabel()
    let button = UIButton(type: .system)
    
    init() {
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(){
        self.addSubview(label)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        //button.backgroundColor = .lightGray
        
        self.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.setTitle("Reload", for: .normal)
        
        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            label.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8),
            label.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            button.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 4),
            button.centerXAnchor.constraint(equalTo: self.centerXAnchor)
            ])
    }
}
