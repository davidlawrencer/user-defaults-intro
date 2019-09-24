//
//  UserDefaultsWrapper.swift
//  Example
//
//  Created by David Rifkin on 9/24/19.
//  Copyright © 2019 David Rifkin. All rights reserved.
//

import Foundation

struct UserDefaultsWrapper {

    // MARK: - singleton
    
    static let wrapper = UserDefaultsWrapper()

    // MARK: - getters
    
    func getUppercaseText() -> Bool? {
        return UserDefaults.standard.value(forKey: isUpperCasedKey) as? Bool
    }

    func getUserName() -> String? {
        return UserDefaults.standard.value(forKey: userNameKey) as? String
    }

    func getFontSize() -> Double? {
        return UserDefaults.standard.value(forKey: fontSizeKey) as? Double
    }
    
    // MARK: - setters
    
    func store(isUppedCased: Bool) {
        UserDefaults.standard.set(isUppedCased, forKey: isUpperCasedKey)
    }
    
    func store(userName: String) {
         UserDefaults.standard.set(userName, forKey: userNameKey)
    }
    
    func store(fontSize: Double){
        UserDefaults.standard.set(fontSize, forKey: fontSizeKey)
    }
    
    // MARK: - private keyNames
    
    private let userNameKey  = "userName"
    private let fontSizeKey = "fontSize"
    private let isUpperCasedKey = "isUpperCased"
}
