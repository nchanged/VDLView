//
//  VDStyle.swift
//  Common
//
//  Created by Ivan Orlov on 06/11/14.
//  Copyright (c) 2014 Conmio. All rights reserved.
//

import Foundation

class VDLElementStyle {
    var styles = [String: VDLStyleValue]()

    init() {

    }

    func add(styleName: String, value: VDLStyleValue) {
        self.styles[styleName] = value;
    }
}