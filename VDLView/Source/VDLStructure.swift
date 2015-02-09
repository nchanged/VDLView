//
//  VDLStructure.swift
//  VDLTest
//
//  Created by Ivan Orlov on 30/01/15.
//  Copyright (c) 2015 Conmio. All rights reserved.
//

import Foundation

class VDLStructure {
    var style: VDLStyleParser!;
    var root: VDLStructureNode;

    init(style: VDLStyleParser!, root: VDLStructureNode) {
        self.style = style;
        self.root = root;
    }
}