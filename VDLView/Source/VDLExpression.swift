//
//  VDLExpression.swift
//  VDLTest
//
//  Created by Ivan Orlov on 30/01/15.
//  Copyright (c) 2015 Conmio. All rights reserved.
//

import Foundation

class VDLExpression {
    var str: String;
    // Stack of parsers
    var stack = [VDLExpressionVariable]();

    // The end result
    var result = [VDLExpressionVariable]();

    // Initiaited parsers
    var parsers: [VDLExpressionVariable]
    = [VDLVariableFloat(), VDLVariableOperation(), VDLVariableReference()]

    init(str: String) {
        self.str = str;
    }

    func compile() -> [VDLExpressionVariable] {
        self.str += ";";
        for symbol in str {
            var c: Character = symbol;
            if (stack.count == 0) {
                for parser in parsers {
                    if (parser.isValid(symbol)) {
                        var p: VDLExpressionVariable!;
                        var parseName = parser.getName();
                        switch (parseName) {
                        case "float":
                            p = VDLVariableFloat();
                            break;
                        case "operation":
                            p = VDLVariableOperation();
                            break;
                        case "reference":
                            p = VDLVariableReference();
                            break;
                        default:
                            break;
                        }
                        p.addChar(c);
                        stack.append(p);
                        break;
                    }
                }
            } else {
                var current: VDLExpressionVariable = stack.last!;

                if current.isValid(c) {
                    current.addChar(c);
                } else {
                    result.append(current);

                    stack.removeLast();
                }
            }
        }
        return result;

    }
}
