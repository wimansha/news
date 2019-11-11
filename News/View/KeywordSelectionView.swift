//
//  KeywordSelectionView.swift
//  News
//
//  Created by Wimansha Chathuranga on 11/9/19.
//  Copyright © 2019 Wimansha. All rights reserved.
//

import UIKit

protocol KeywordSelectionViewDelegate {
    func didSelect(keyword: String)
}

class KeywordSelectionView: UIView, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    var _columnCount: Int!
    var _cellSpace: CGFloat!
    
    let keywords = ["bitcoin", "apple", "earthquake", "animal"]
    
    var selectedKeyword : String
    
    var delegate : KeywordSelectionViewDelegate?
    
    init() {
        selectedKeyword = keywords[0]
        super.init(frame: CGRect.zero)
        _columnCount = 4
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
        flowLayout.scrollDirection = .horizontal
        
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
        
        collectionView.register(KeywordCell.self, forCellWithReuseIdentifier: KeywordCell.identifier)
        collectionView.backgroundColor = UIColor.clear
        self.addSubview(collectionView)
        
        let views = ["collectionView":collectionView]
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[collectionView]-0-|", options: [], metrics: nil, views: views))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[collectionView]-0-|", options: [], metrics: nil, views: views))
    }
    
    //MARK:- UICollectionViewDataSource methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return keywords.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KeywordCell.identifier, for: indexPath) as? KeywordCell
        cell?.titleLabel.text = keywords[indexPath.item]
        return cell!
    }
    
    //MARK:- UICollectionViewDelegateFlowLayout delegate methods
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var width, height: CGFloat!
        width = (collectionView.frame.size.width - (_cellSpace*CGFloat(_columnCount+1)))/CGFloat(_columnCount);
        height = collectionView.frame.size.height
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedKeyword = keywords[indexPath.item]
        delegate?.didSelect(keyword: selectedKeyword)
    }

}
