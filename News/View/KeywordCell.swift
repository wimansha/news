//
//  KeywordCell.swift
//  News
//
//  Created by Wimansha Chathuranga on 11/9/19.
//  Copyright © 2019 Wimansha. All rights reserved.
//

import UIKit

class KeywordCell: UICollectionViewCell {
    
    static let identifier = "KeywordCell"
    
    let titleLabel = UILabel()
    let selectionView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(){
        contentView.addSubview(selectionView)
        selectionView.backgroundColor = .gray
        selectionView.isHidden = true
        selectionView.layer.cornerRadius = 4
        selectionView.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.textColor = .gray
        titleLabel.numberOfLines = 1
        titleLabel.layer.cornerRadius = 5
        self.contentView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.systemFont(ofSize: 14)
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            selectionView.centerXAnchor.constraint(equalTo: titleLabel.centerXAnchor),
            selectionView.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            selectionView.widthAnchor.constraint(equalTo: titleLabel.widthAnchor, constant: 4),
            selectionView.heightAnchor.constraint(equalTo: titleLabel.heightAnchor, constant: 4),
            ])
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected == true{
                titleLabel.textColor = .white
                selectionView.isHidden = false
            }else{
                titleLabel.textColor = .gray
                selectionView.isHidden = true
            }
        }
    }
}
