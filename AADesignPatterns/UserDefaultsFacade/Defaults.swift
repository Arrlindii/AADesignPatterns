//
//  Defaults.swift
//  AADesignPatterns
//
//  Created by Arlind on 8/19/18.
//  Copyright © 2018 Arlind Aliu. All rights reserved.
//

import Foundation

class Defaults {
    static var mainFormStates: [Memento] {
        get {
            return UserDefaults.standard.array(forKey: UserDefaultConstants.mainForm.rawValue) as? [Memento] ?? [Memento]()
        }
        set {
            UserDefaults.standard.set(newValue, forKey: UserDefaultConstants.mainForm.rawValue)
            UserDefaults.standard.synchronize()
        }
    }
}

enum UserDefaultConstants: String {
    case mainForm
}
