//
//  FormVersionManager.swift
//  AADesignPatterns
//
//  Created by Arlind on 8/19/18.
//  Copyright © 2018 Arlind Aliu. All rights reserved.
//

import Foundation

struct FormVersionManager {
    static func generateVersionName() -> String {
        let versionNumber = Defaults.mainFormStates.count + 1
        return "Version \(versionNumber)"
    }
}
