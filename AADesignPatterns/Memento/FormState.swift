//
//  FormState.swift
//  AADesignPatterns
//
//  Created by Arlind on 8/19/18.
//  Copyright © 2018 Arlind Aliu. All rights reserved.
//

import Foundation

struct FormState {
    private enum Keys {
        static let name = "mainForm.name"
        static let surname = "mainForm.surname"
        static let email =  "mainForm.email"
        static let address = "mainForm.address"
        static let personalInfo = "mainForm.personalInfo"
        static let dateSaved = "mainForm.dateSaved"
        static let essayField = "mainForm.essay"
        static let versionName = "versionName"
    }
    
    var name: String
    var surname: String
    var address: String
    var essay: String
    var email: String
    var versionName: String
    var dateSaved: Date = Date()
    
    init(name: String, surname: String, address:String, essay: String, email: String) {
        self.name = name
        self.surname = surname
        self.email = email
        self.address = address
        self.essay = essay
        self.versionName = FormVersionManager.generateVersionName()
        self.dateSaved = Date()
    }
}

extension FormState: MementoConvertible {
    var memento: Memento {
        return  [Keys.name: name, Keys.surname: surname, Keys.email: email, Keys.address: address, Keys.essayField: essay, Keys.versionName: versionName, Keys.dateSaved: dateSaved]
    }
    
    init(memento: Memento) {
        name = memento[Keys.name] as? String ?? ""
        surname = memento[Keys.surname] as? String ?? ""
        email = memento[Keys.email] as? String ?? ""
        address = memento[Keys.address] as? String ?? ""
        essay = memento[Keys.essayField] as? String ?? ""
        versionName = memento[Keys.versionName] as? String ?? ""
        dateSaved = memento[Keys.dateSaved] as? Date ?? Date()
    }
}
