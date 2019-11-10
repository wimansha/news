//
//  NewsCell.swift
//  News
//
//  Created by Wimansha Chathuranga on 11/9/19.
//  Copyright © 2019 Wimansha. All rights reserved.
//

import UIKit
import SDWebImage

class NewsCell: UICollectionViewCell {
    
    static let identifier = "KeywordCell"
    
    let titleLabel = UILabel()
    let descriptionLabel = UILabel()
    let thumbImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    func configure(){
        self.clipsToBounds = true
        
        thumbImageView.contentMode = .scaleAspectFill
        thumbImageView.clipsToBounds = true
        thumbImageView.layer.cornerRadius = 10
        self.contentView.addSubview(thumbImageView)
        thumbImageView.backgroundColor = .gray
        thumbImageView.translatesAutoresizingMaskIntoConstraints = false
        
        self.contentView.backgroundColor = .white
        
        titleLabel.textColor = .black
        titleLabel.numberOfLines = 2
        titleLabel.textAlignment = .left
        self.contentView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.systemFont(ofSize: 14)
        
        descriptionLabel.textColor = .darkGray
        descriptionLabel.lineBreakMode = .byWordWrapping
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textAlignment = .left
        //descriptionLabel.sizeToFit()
        descriptionLabel.font = UIFont.systemFont(ofSize: 10)
        self.contentView.addSubview(descriptionLabel)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        //constraints
        
        let margin : CGFloat = 4
        let margin_1 : CGFloat = 10
        
        thumbImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: margin).isActive = true
        thumbImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -margin).isActive = true
        thumbImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: margin).isActive = true
        thumbImageView.widthAnchor.constraint(equalTo: thumbImageView.heightAnchor).isActive = true
        
        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: margin).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: thumbImageView.trailingAnchor, constant: margin_1).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -margin).isActive = true
        
        descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 0).isActive = true
        descriptionLabel.leadingAnchor.constraint(equalTo: thumbImageView.trailingAnchor, constant: margin_1).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -margin).isActive = true
        descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -margin).isActive = true
        
        titleLabel.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(news : News){
        titleLabel.text = news.title
        descriptionLabel.text = news.description
        thumbImageView.sd_setImage(with: news.imgUrl, completed: nil)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        descriptionLabel.text = nil
        thumbImageView.image = nil
    }
}
