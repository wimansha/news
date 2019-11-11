//
//  ProfileViewController.swift
//  News
//
//  Created by Wimansha Chathuranga on 11/9/19.
//  Copyright © 2019 Wimansha. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    let usernameField = UITextField()
    let usernameLabel = UILabel()
    let button = UIButton()
    
    func updateState(){
        if AuthenticationManager.shared.state == .loggedIn{
            usernameLabel.isHidden = false
            usernameField.isHidden = true
            button.setTitle("Logout", for: .normal)
            button.backgroundColor = .gray
            usernameLabel.text = "Welcome \(AuthenticationManager.shared.loggedUsername() ?? "user") !"
        }else{
            usernameLabel.isHidden = true
            usernameField.isHidden = false
            button.setTitle("Login", for: .normal)
            button.backgroundColor = .blue
            usernameLabel.text = nil
        }
    }

    init() {
        super.init(nibName: nil, bundle: nil)
        self.navigationItem.title = "Profile"
        configure()
        updateState()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(){
        self.view.backgroundColor = .white
        
        usernameField.placeholder = "Enter Username"
        usernameField.textAlignment = .center
        usernameField.autocapitalizationType = .none
        view.addSubview(usernameField)
        usernameField.translatesAutoresizingMaskIntoConstraints = false
        
        usernameLabel.textAlignment = .center
        
        view.addSubview(usernameLabel)
        usernameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        button.setTitleColor(.white, for: .normal)
        view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            usernameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            usernameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            usernameLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -10),
            usernameLabel.heightAnchor.constraint(equalToConstant: 20),
            
            usernameField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            usernameField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            usernameField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -10),
            
            button.topAnchor.constraint(equalTo: usernameField.bottomAnchor, constant: 10),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            button.heightAnchor.constraint(equalToConstant: 30),
            ])
    }
    
    @objc func buttonTapped(){
        if AuthenticationManager.shared.state == .loggedOut{
            if usernameField.text!.count > 0{
                let username = usernameField.text
                AuthenticationManager.shared.logIn(username: username!)
                usernameField.text = nil
                updateState()
            }else{
                let alert = UIAlertController(title: "Error", message: "Please enter a username", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                present(alert, animated: true, completion: nil)
            }
            
        }else{
            AuthenticationManager.shared.logOut()
            updateState()
        }
    }

}
