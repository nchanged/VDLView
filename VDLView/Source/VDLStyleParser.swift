//
//  VDLStyle.swift
//  Common
//
//  Created by Ivan Orlov on 06/11/14.
//  Copyright (c) 2014 Conmio. All rights reserved.
//

import Foundation
import UIKit;
/*

	#contentView {
	left:0;
	right:0; top:0; bottom : 0;
	border: 1 red;
	}
	#test {
	border: 1px solid red;
	}

*/

class VDLStyleParser {

    var styles = [String: VDLElementStyle]()
    init(stringValue: String) {
        var groups = stringValue["(#(\\w*)\\s+?\\{([^\\}]+))"].allGroups()
        for item in groups {
            var viewID = item[2]
            var unparsedStyles = item[3]


            var vdlStyle = VDLElementStyle()
            self.styles[viewID] = vdlStyle

            // Matching styles
            var styleGroups = unparsedStyles["(([\\w-]*)(\\s+)?:(\\s+)?([^;]+))"].allGroups()
            for style in styleGroups {

                var styleName = style[2]
                vdlStyle.add(styleName, value: VDLStyleValue(fullValue: style[5]))
            }

        }
    }
}
