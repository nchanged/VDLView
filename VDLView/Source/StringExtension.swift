//
//  Ext.swift
//  RSBarcodesSample
//
//  Created by R0CKSTAR on 6/10/14.
//  Copyright (c) 2014 P.D.Q. All rights reserved.
//

import UIKit


extension CGFloat {

    func getRad() -> CGFloat {

        let twoPi = CGFloat(2.0 * Double(M_PI));
        var a = CGFloat(self / 360)
        return CGFloat(a * twoPi)
    }
}


extension String {

    func length() -> Int {
        return countElements(self)
    }

    func trim() -> String {
        return self.stringByTrimmingCharactersInSet(.whitespaceAndNewlineCharacterSet())
    }

    func substring(location: Int, length: Int) -> String! {
        return (self as NSString).substringWithRange(NSMakeRange(location, length))
    }

    func split(separator: String) -> [String] {
        return self.componentsSeparatedByString(separator)
    }

    func replace(target: String, withString: String) -> String {
        return self.stringByReplacingOccurrencesOfString(target, withString: withString, options: nil, range: nil)
    }


    //var toFloat:Float {
//		return Float(self.bridgeToObjectiveC().floatValue)
//	}


    subscript(index: Int) -> String! {
        get {
            return self.substring(index, length: 1)
        }
    }

    func location(other: String) -> Int {
        return (self as NSString).rangeOfString(other).location
    }

    func uppercase() -> String {

        var output = ""
        for chr in self {
            var str = String(chr).uppercaseString
            output += str

        }
        return output;
    }

    func contains(other: String) -> Bool {
        return (self as NSString).containsString(other)
    }

    // http://stackoverflow.com/questions/6644004/how-to-check-if-nsstring-is-contains-a-numeric-value
    func isNumeric() -> Bool {
        return (self as NSString).rangeOfCharacterFromSet(NSCharacterSet.decimalDigitCharacterSet().invertedSet).location == NSNotFound
    }
}