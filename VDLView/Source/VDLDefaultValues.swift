//
// Created by Ivan Orlov on 05/02/15.
// Copyright (c) 2015 Conmio. All rights reserved.
//

import Foundation

@objc class VDLDefaultValues: NSObject {
    var values = [String: String]();

    override init() {

    }


    func getValue(id: String) -> String! {
        return values[id];
    }

    func addValue(id: String, value: String) {
        self.values[id] = value;
    }
}
