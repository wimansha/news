//
//  AuthenticationManager.swift
//  News
//
//  Created by Wimansha Chathuranga on 11/11/19.
//  Copyright © 2019 Wimansha. All rights reserved.
//

import UIKit

class AuthenticationManager {
    
    static let notificationName = Notification.Name(rawValue: "AuthenticationManagerStateChanged")
    
    enum State {
        case loggedOut
        case loggedIn
    }
    
    var state : State{
        if loggedUsername() != nil{
            return .loggedIn
        }
        return .loggedOut
    }
    
    static let shared = AuthenticationManager()
    
    init() {
        
    }
    
    private let loggedUserKey = "loggedUser"
    private let userPreferencesKey = "userPreferences"
    
    func loggedUsername() -> String?{
        return UserDefaults.standard.string(forKey: loggedUserKey)
    }
    
    func logIn(username : String){
        set(loggedUsername: username)
        loginStateUpadted()
    }
    
    func logOut(){
        UserDefaults.standard.removeObject(forKey: loggedUserKey)
        loginStateUpadted()
    }
    
    func loginStateUpadted(){
        NotificationCenter.default.post(name: AuthenticationManager.notificationName, object: nil)
    }
    
    private func set(loggedUsername : String){
        UserDefaults.standard.set(loggedUsername, forKey: loggedUserKey)
    }
    
    func preferedKeywordForCurrentUser() -> String?{
        if state == .loggedOut{
            return nil
        }
        return preferedKeyword(for: loggedUsername()!)
    }
    
    private func preferedKeyword(for username : String) -> String?{
        var userPreference = userPreferences()
        return userPreference?[username]
    }
    
    func setCurrentUser(preferedKeyword : String){
        if state == .loggedOut{
            return
        }
        set(preferedKeyword: preferedKeyword, of: loggedUsername()!)
    }
    
    private func set(preferedKeyword : String, of username : String){
        var userPreference = userPreferences()
        if userPreference == nil {
            userPreference = [String:String]()
        }
        userPreference![username] = preferedKeyword
        update(userPreferences: userPreference!)
    }
    
    private func userPreferences() -> [String:String]?{
        return UserDefaults.standard.value(forKey: userPreferencesKey) as? [String : String]
    }
    
    private func update(userPreferences : [String:String]){
        UserDefaults.standard.set(userPreferences, forKey: userPreferencesKey)
    }

}
