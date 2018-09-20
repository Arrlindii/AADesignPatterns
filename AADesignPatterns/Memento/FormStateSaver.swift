//
//  Memento.swift
//  AADesignPatterns
//
//  Created by Arlind on 8/19/18.
//  Copyright © 2018 Arlind Aliu. All rights reserved.
//

import Foundation

typealias Memento = NSDictionary

protocol MementoConvertible {
    var memento: Memento { get }
    init?(memento: Memento)
}

//CareTaker
struct FormStateSaver {
    static func save(_ state: MementoConvertible) {
        Defaults.mainFormStates.append(state.memento)
    }

    static func restore() -> [FormState] {
        return Defaults.mainFormStates.map {FormState(memento: $0)}
    }
    
    static func removeAllStates() {
        Defaults.mainFormStates = []
    }
    
    static func restoreLatest() -> FormState? {
        return self.restore().sorted(by: { $0.dateSaved > $1.dateSaved }).first
    }
}
