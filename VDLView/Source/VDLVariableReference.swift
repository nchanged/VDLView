//
//  VDLVariableReference.swift
//  VDLTest
//
//  Created by Ivan Orlov on 30/01/15.
//  Copyright (c) 2015 Conmio. All rights reserved.
//

import Foundation

class VDLVariableReference: VDLExpressionVariable {
    override func getName() -> String {
        return "reference";
    }

    var allowed: String = "$_.abcdfeghijklmnopqrstuvwxyz1234567890";
    override func getAllowed() -> String {
        return allowed;
    }

    override func addChar(c: Character) {
        if (c != "$") {
            self.str += String(c);
        }
    }
}