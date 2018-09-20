//
//  DateExtensions.swift
//  AADesignPatterns
//
//  Created by Arlind on 8/21/18.
//  Copyright © 2018 Arlind Aliu. All rights reserved.
//

import Foundation

extension Date {
    func toString() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = DateFormatter.Style.medium
        formatter.timeStyle = DateFormatter.Style.short
        return formatter.string(from: self)
    }
}
