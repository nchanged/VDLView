//
//  VDLStyleValue.swift
//  Common
//
//  Created by Ivan Orlov on 06/11/14.
//  Copyright (c) 2014 Conmio. All rights reserved.
//

import Foundation
import UIKit;

class VDLStyleValue {
    var fullValue: String!;
    var options = [String]();
    var expression: [VDLExpressionVariable]!;

    init(fullValue: String) {
        self.fullValue = fullValue
        var groups = self.fullValue["([^\\s]+)"].allGroups()

        for attr in groups {
            self.options.append(attr[0])
        }

        if self.fullValue["\\$"].allGroups().count > 0 {

            var e = VDLExpression(str: self.fullValue);
            self.expression = e.compile();
        }
    }

    func getFullString() -> String {
        return self.fullValue
    }

    func hasOneArg() -> Bool {
        return self.options.count == 1
    }

    func hasTwoArgs() -> Bool {
        return self.options.count == 2
    }

    func hasThreeArgs() -> Bool {
        return self.options.count == 3
    }

    private func getString(position: Int) -> String {
        return self.options.count > position ? self.options[position] : ""
    }

    // Returns string
    func getFirstAsString() -> String {
        return self.getString(0)
    }

    // Returns string
    func getSecondAsString() -> String {
        return self.getString(1)
    }

    // Returns string
    func getThirdAsString() -> String {
        return self.getString(2)
    }

    private func getFloat(position: Int) -> CGFloat {
        return self.options.count > position ?
                CGFloat(NSString(string: self.options[position]).floatValue)
                : CGFloat(0.0)
    }

    // Returns CGFloat, if value is not found, gives zero
    func getFirstAsFloat() -> CGFloat {
        return self.getFloat(0)
    }

    func getSecondAsFloat() -> CGFloat {
        return self.getFloat(1)
    }

    func getThirdAsFloat() -> CGFloat {
        return self.getFloat(2)
    }
}