//
//  VDLExpressionVariable.swift
//  VDLTest
//
//  Created by Ivan Orlov on 30/01/15.
//  Copyright (c) 2015 Conmio. All rights reserved.
//

import Foundation


class VDLExpressionVariable {
    var str: String = "";
    var name: String = "";
    init() {

    }

    func getName() -> String {
        return "none";
    }

    func getAllowed() -> String {
        return "";
    }

    func addChar(c: Character) {
        self.str += String(c);
    }

    func getData() -> [String] {
        return self.str.split(".");
    }

    func containsCharacter(str: String, search: Character) -> Bool {
        for s in str {
            if (s == search) {
                return true;
            }
        }
        return false;
    }

    func isValid(input: Character) -> Bool {

        return containsCharacter(getAllowed(), search: input);
    }

}