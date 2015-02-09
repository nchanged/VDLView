//
//  VDLCreator.swift
//  VDLTest
//
//  Created by Ivan Orlov on 30/01/15.
//  Copyright (c) 2015 Conmio. All rights reserved.
//


import Foundation
import UIKit;

@objc class VDLCreator {
    var structure: VDLStructure;
    var size: CGSize;
    var idStructure = [String: VDLBaseView]();
    var nodeStructureInOrder = [VDLBaseView]();
    var defaultValues: VDLDefaultValues!;

    init(structure: VDLStructure, size: CGSize, values: VDLDefaultValues!) {
        self.structure = structure;
        self.size = size;
        self.defaultValues = values;
        //self.structure.root
        var a: ASDisplayNode = ASTextNode();

    }

    func getImageById(id: String) -> VDLImageView! {
        var target: VDLImageView!;
        if let image = idStructure[id] {
            target = image as VDLImageView;
        }
        return target;
    }

    func getLabelById(id: String) -> VDLLabelView! {
        var target: VDLLabelView!;
        if let label = idStructure[id] {
            target = label as VDLLabelView;
        }
        return target;
    }

    func getViewById(id: String) -> VDLBaseView! {
        var target: VDLBaseView!;
        if let view = idStructure[id] {
            target = view as VDLBaseView;
        }
        return target;
    }

    func create() -> ASDisplayNode {
        var rootNode = VDLBaseView(layer: ASDisplayNode());
        var structureRoot = self.structure.root;

        // root should have some special properties
        rootNode.layer.frame = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height);
        rootNode.width = self.size.width;
        rootNode.height = self.size.height;
        rootNode.layer.layerBacked = true
        rootNode.layer.shouldRasterizeDescendants = true

        self.process(structureRoot, rootNode: rootNode);
        self.styleNodes();
        return rootNode.layer;
    }

    func styleNodes() {
        if (self.structure.style != nil) {
            for item in nodeStructureInOrder {

                if let s = self.structure.style.styles[item.node.id] {
                    item.setStyle(s);
                }
            }
        }
    }

    // Recursively proccess all the nodes and create structure
    func process(node: VDLStructureNode, rootNode: VDLBaseView) {
        rootNode.node = node;
        // Register current id
        if let id = node.id {
            nodeStructureInOrder.append(rootNode);
            // Setting default value if default values dict is defined
            if (self.defaultValues != nil) {
                if let v = self.defaultValues.getValue(id) {
                    rootNode.setDefaultValue(v);
                }
            }

            idStructure[id] = rootNode;
        }

        for item in node.nodes {
            var child: VDLBaseView = getCorrespondingView(item.name);
            child.idStructure = idStructure;
            child.parent = rootNode;
            rootNode.addChild(child);
            process(item, rootNode: child);
        }
    }

    func getCorrespondingView(name: String) -> VDLBaseView! {
        var view: ASDisplayNode!;
        switch (name) {
        case "view":
            return VDLBaseView(layer: ASDisplayNode());
        case "label":
            return VDLLabelView(layer: ASTextNode());
        case "image":
            return VDLImageView(layer: ASImageNode());
        case "gradient":
		
            return VDLGradientNode(layer: GradientNode());
        default:
            break;
        }
        return VDLBaseView(layer: ASDisplayNode());
    }

}