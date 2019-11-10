//
//  NewsViewController.swift
//  News
//
//  Created by Wimansha Chathuranga on 11/10/19.
//  Copyright © 2019 Wimansha. All rights reserved.
//

import UIKit
import SDWebImage
import SafariServices

class NewsViewController: UIViewController {
    
    let imageView = UIImageView()
    let titleLabel = UILabel()
    let descriptionTextView = UITextView()
    let showOriginalButton = UIButton(type: .system)
    
    let news : News
    
    init(news : News) {
        self.news = news
        super.init(nibName: nil, bundle: nil)
        configure()
        navigationItem.title = "Details"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.sd_setImage(with: news.imgUrl, completed: nil)
        titleLabel.text = news.title
        descriptionTextView.text = news.description
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(){
        self.view.backgroundColor = .white
        self.view.clipsToBounds = true
        
        view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .gray
        imageView.contentMode = .scaleAspectFill
        
        view.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textColor = .black
        titleLabel.textAlignment = .center
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.numberOfLines = 0
        titleLabel.sizeToFit()
        titleLabel.font = UIFont.systemFont(ofSize: 18)
        
        view.addSubview(descriptionTextView)
        descriptionTextView.translatesAutoresizingMaskIntoConstraints = false
        descriptionTextView.isEditable = false
        descriptionTextView.textAlignment = .left
        descriptionTextView.textColor = .darkGray
        descriptionTextView.font = UIFont.systemFont(ofSize: 12)
        
        showOriginalButton.setTitle("Show Original", for: .normal)
        showOriginalButton.addTarget(self, action: #selector(showOriginal), for: .touchUpInside)
        view.addSubview(showOriginalButton)
        showOriginalButton.translatesAutoresizingMaskIntoConstraints = false
        
        let views = ["imageView":imageView, "titleLabel":titleLabel, "descriptionTextView":descriptionTextView]
        let metrics = ["margin":8]
        
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[imageView]-margin-[titleLabel]-margin-[descriptionTextView]-|", options: [], metrics: metrics, views: views))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[titleLabel]-0-|", options: [], metrics: metrics, views: views))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[descriptionTextView]-0-|", options: [], metrics: metrics, views: views))
        
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.widthAnchor.constraint(equalTo: view.widthAnchor),
            imageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5),
            
            showOriginalButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -4),
            showOriginalButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ])
        
    }
    
    @objc func showOriginal(){
        if let url = news.originlNewsUrl {
            let vc = SFSafariViewController(url: url)
            present(vc, animated: true)
        }
    }
}
