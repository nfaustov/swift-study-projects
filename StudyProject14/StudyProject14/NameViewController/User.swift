//
//  User.swift
//  StudyProject14
//
//  Created by Nikolai Faustov on 08.03.2021.
//

import Foundation

@propertyWrapper
struct StoredField<T> {
    var key: String
    var defaultValue: T
    
    var wrappedValue: T {
        get {
            UserDefaults.standard.object(forKey: key) as? T ?? defaultValue
        }
        set {
            UserDefaults.standard.set(newValue, forKey: key)
        }
    }
}

enum UserKeyes {
    static let firstNameKey = "firstNameKey"
    static let secondNameKey = "secondNameKey"
}

struct User {
    @StoredField(key: UserKeyes.firstNameKey, defaultValue: "")
    var firstName: String
    @StoredField(key: UserKeyes.secondNameKey, defaultValue: "")
    var secondName: String
}
