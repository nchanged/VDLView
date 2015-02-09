//
//  VDLVariableOperation.swift
//  VDLTest
//
//  Created by Ivan Orlov on 30/01/15.
//  Copyright (c) 2015 Conmio. All rights reserved.
//

import Foundation


class VDLVariableOperation: VDLExpressionVariable {
    override func getName() -> String {
        return "operation";
    }

    var allowed: String = "+-/*";
    override func getAllowed() -> String {
        return allowed;
    }

}