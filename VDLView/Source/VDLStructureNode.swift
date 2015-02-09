//
//  VDLStructureNode.swift
//  VDLTest
//
//  Created by Ivan Orlov on 30/01/15.
//  Copyright (c) 2015 Conmio. All rights reserved.
//

import Foundation

class VDLStructureNode {
    var name: String;
    var nodes = [VDLStructureNode]();
    var id: String!;

    init(name: String) {
        self.name = name;
    }

    func addNode(node: VDLStructureNode) {
        self.nodes.append(node);
    }

}
