//
//  VDLBuilder.swift
//  VDLTest
//
//  Created by Ivan Orlov on 30/01/15.
//  Copyright (c) 2015 Conmio. All rights reserved.
//

import Foundation
import UIKit;

var VDLBuilderStructures = [String: VDLStructure]()

@objc class VDLBuilder: NSObject {


    // The main entry is here
    // into is a view that considered to be a root
    // It does not reall inflate it here, but "into" must present so
    // we will be able to obtain params from it (like width and height)
    @objc class func inflate(target: String, size: CGSize, values: VDLDefaultValues!) -> VDLWorld! {

        var that = self;
        var world = VDLWorld();


        var structure: VDLStructure!;

        if VDLBuilderStructures[target] != nil {
            structure = VDLBuilderStructures[target];
        } else {
            var xml: AEXMLDocument = that.getXML(target);

            structure = that.buildNodes(xml);
            VDLBuilderStructures[target] = structure;
        }

        var creator = VDLCreator(structure: structure, size: size, values: values);
        var displayNode: ASDisplayNode = creator.create();
        displayNode.layerBacked = false;


        world.rootNode = displayNode;
        world.creator = creator;

        return world;
    }



    // Getting aexml struction from a filename
    private class func getXML(target: String) -> AEXMLDocument! {
        let bundle = NSBundle.mainBundle()
        let path = bundle.pathForResource(target, ofType: "vdl")
        // Getting data from the file
        var content = NSData(contentsOfFile: path!)
        var res: AEXMLDocument!;
        var error: NSError?

        if let cnt = String(contentsOfFile: path!, encoding: NSUTF8StringEncoding, error: &error) {
            // Adding root node to the string xml feed
            var xmlStringWithRoot = "<root>\(cnt)</root>";
            var data: NSData = xmlStringWithRoot.dataUsingEncoding(NSUTF8StringEncoding)!
            // Creating nodes

            if let xmlDoc = AEXMLDocument(xmlData: data, error: &error) {
                res = xmlDoc;
            }
        }
        return res;
    }

    // Return a structure that contain root node
    // And style attached
    class func buildNodes(xml: AEXMLDocument!) -> VDLStructure {
        var root = VDLStructureNode(name: "root");
        root.id = "root";


        var styleParser: VDLStyleParser! = parse(root, rootElement: xml.rootElement);
        var structure = VDLStructure(style: styleParser, root: root);


        return structure;
    }

    // Recursive function that parses all the nodes and returns style (if present)
    class func parse(rootView: VDLStructureNode, rootElement: AEXMLElement) -> VDLStyleParser! {
        var parser: VDLStyleParser!;

        for element in rootElement.children {
            if (element.name == "style") {

                parser = VDLStyleParser(stringValue: element.value);

            } else {
                var child = VDLStructureNode(name: element.name);
                if element.attributes["id"] != nil {
                    // Setting id to a child
                    var id: String = element.attributes["id"] as String;
                    child.id = id;
                }
                rootView.addNode(child);

                if element.children.count > 0 {
                    parse(child, rootElement: element)
                }
            }
        }
        return parser;
    }
}