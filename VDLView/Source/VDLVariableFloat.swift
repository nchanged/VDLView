//
//  VDLVariableFloat.swift
//  VDLTest
//
//  Created by Ivan Orlov on 30/01/15.
//  Copyright (c) 2015 Conmio. All rights reserved.
//

import Foundation


class VDLVariableFloat: VDLExpressionVariable {
    override func getName() -> String {
        return "float";
    }


    var allowed: String = "01234567890.";

    override func getAllowed() -> String {
        return allowed;
    }

}