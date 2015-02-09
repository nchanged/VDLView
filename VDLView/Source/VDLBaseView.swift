//
//  VDLBaseView.swift
//  VDLTest
//
//  Created by Ivan Orlov on 30/01/15.
//  Copyright (c) 2015 Conmio. All rights reserved.
//

import Foundation
import UIKit;

@objc class VDLBaseView {
    var layer: ASDisplayNode;
    var node: VDLStructureNode!;
    var parent: VDLBaseView!;

    // Compiled values
    var width: CGFloat = 0;
    var height: CGFloat = 0;
    var left: CGFloat = 0;
    var top: CGFloat = 0;
    var maxWidth: CGFloat = 0;
    var gradientFrom : UIColor!;
    var gradientTo : UIColor!;

    var idStructure: [String:VDLBaseView]!;

    var widthValue: VDLStyleValue!;
    var heightValue: VDLStyleValue!;
    var topValue: VDLStyleValue!;
    var leftValue: VDLStyleValue!;

    var maxWidthValue: VDLStyleValue!;

    var attrs = [String: VDLStyleValue]();


    init(layer: ASDisplayNode) {
        self.layer = layer;
        self.layer.layerBacked = true;
        self.onInit();
    }


    func onInit() {

    }

    func setDefaultValue(values: String) {

    }

    func addChild(node: VDLBaseView) {
        self.layer.addSubnode(node.layer);
    }

    private func proccessStyle(styleKey: String, value: VDLStyleValue) {

        switch (styleKey) {
        case "width": setWidth(value); break;
        case "max-width": setMaxWidth(value); break;
        case "height": setHeight(value); break;
        case "left": setLeft(value); break;
        case "top": setTop(value); break;
        case "border": setBorder(value); break;
        case "background-color": setBackgroundColor(value); break;
        case "text": setTextValue(value); break;
        case "font": setFont(value); break;
        case "color": setColor(value); break;
		case "opaque": setOpaque(value); break;
        case "foreground-color": setForegroundColor(value); break;
        case "align": setAlign(value); break;
        case "display": setDisplay(value); break;
        case "resize": setResize(value); break;
        case "cache": setCache(value); break;
        case "image": setImage(value); break;
		case "alpha": setAlpha(value); break;
        case "src": setImage(value); break;
        case "gradient-from": setGradientFrom(value); break;
        case "gradient-to": setGradientTo(value); break;
        default:
            break;
        }
    }
	func setOpaque(value : VDLStyleValue)
	{
		var isIOpaque : Bool = value.getFirstAsString() == "true";
		self.layer.opaque = isIOpaque;
	}
	
	func setAlpha(value : VDLStyleValue)
	{
		self.layer.opaque = false;
		self.layer.layerBacked = false;
		self.layer.alpha = value.getFirstAsFloat();
	}

    func setGradientFrom(value: VDLStyleValue)
    {

        self.gradientFrom = self.getColor(value);
    }

    func setGradientTo(value: VDLStyleValue)
    {
        self.gradientTo = self.getColor(value);
    }

    func show() {
		self.layer.opaque = false;
		self.layer.alpha = 1;

    }

    func hide() {
		
		self.layer.alpha = 0;
    }

    func setResize(value: VDLStyleValue) {

    }

    func setCache(value: VDLStyleValue) {

    }

    func setImage(value: VDLStyleValue) {

    }

    func setDisplay(value: VDLStyleValue) {
        var display = value.getFirstAsString()
        if (display == "block") {
            show();
        }
        if (display == "none") {
            hide();
        }
    }



    func setBorder(value: VDLStyleValue) {
        var color = "black";
        var size: CGFloat = 1

        color = value.getFirstAsString()

        if value.hasTwoArgs() {
            size = value.getSecondAsFloat()
        }

        self.layer.borderWidth = size;
        self.layer.borderColor = UIColor(rgba: ColorHelper.getColor(color)).CGColor
    }

    func setForegroundColor(value: VDLStyleValue) {

    }

    func setTextValue(value: VDLStyleValue) {

    }

    func setFont(value: VDLStyleValue) {

    }

    func setAlign(value: VDLStyleValue) {

    }

    func setColor(value: VDLStyleValue) {

    }

    // Compiling expressions
    func compileExpression(expressions: [VDLExpressionVariable]!) -> CGFloat {

        var result: CGFloat = 0.0;
        var operation = "+";

        for exp in expressions {
            var value: CGFloat!;
            if exp is VDLVariableReference {
                var expVar = exp as VDLVariableReference;
                // Returns a list with 2 variables
                // Assume that the first one is the reference to id object
                var data = expVar.getData();
                var id = data[0];
                var param = data[1];


                var targetView: VDLBaseView = self;

                if id == "parent" {
                    targetView = self.parent;
                }

                if let target = idStructure[id] {
                    targetView = target;
                }



                // Checkign value
                switch (param) {
                case "width":
                    value = targetView.width;
                    break;
                case "height":
                    value = targetView.height;
                    break;
                case "left":
                    value = targetView.left;
                    break;
                case "top":
                    value = targetView.top;
                    break;
                default:
                    break;
                }

            }

            if exp is VDLVariableFloat {
                var expVar = exp as VDLVariableFloat;
                value = CGFloat((expVar.str as NSString).doubleValue)

            }

            if exp is VDLVariableOperation {
                var expVar = exp as VDLVariableOperation;
                operation = expVar.str;
            }

            if (value != nil) {
                switch (operation) {
                case "+":
                    result += value;
                    break;
                case "-":
                    result -= value;
                    break;
                case "*":
                    result *= value;
                    break;
                case "/":
                    result /= value;
                    break;
                default:
                    break;
                }
            }
        }

        return result;
    }

    func setWidth(value: VDLStyleValue) {
        self.width = value.getFirstAsFloat();
        self.widthValue = value;
        if (value.expression != nil) {
            self.width = self.compileExpression(value.expression);
        }
    }
    func setHeight(value: VDLStyleValue) {
        self.heightValue = value;

        self.height = value.getFirstAsFloat();
        if (value.expression != nil) {
            self.height = self.compileExpression(value.expression);
        }
    }

    func setTop(value: VDLStyleValue) {
        self.topValue = value;

        self.top = value.getFirstAsFloat();
        if (value.expression != nil) {
            self.top = self.compileExpression(value.expression);
        }
    }
    func setLeft(value: VDLStyleValue) {

        self.leftValue = value;

        self.left = value.getFirstAsFloat();
        if (value.expression != nil) {
            self.left = self.compileExpression(value.expression);
        }
    }

    func setMaxWidth(value: VDLStyleValue) {
        self.maxWidthValue = value;
    }



    func setBackgroundColor(value: VDLStyleValue) {
        self.layer.backgroundColor = self.getColor(value);
    }

    func getColor(value: VDLStyleValue) -> UIColor {
        var alpha: CGFloat = 1.0
        if value.hasTwoArgs() {
            alpha = value.getSecondAsFloat()
        }
        return UIColor(rgba: ColorHelper.getColor(value.getFirstAsString()), alpha: alpha);
    }

    func computeWidth() -> CGFloat {

        var v: CGFloat = 0;

        if let w = self.attrs["width"] {
            v = w.getFirstAsFloat();
            if (w.expression != nil) {
                v = self.compileExpression(w.expression);
            }
        }
        return v;
    }

    func computeHeight() -> CGFloat {
        var v: CGFloat = 0;
        if let h = self.attrs["height"] {
            v = h.getFirstAsFloat();
            if (h.expression != nil) {
                v = self.compileExpression(h.expression);
            }
        }
        return v;
    }

    func poke() {
        self.stylesAttached();
    }


    func stylesAttached() {
        var frame = self.layer.frame;

        var x = frame.origin.x
        var y = frame.origin.y;


        if (self.topValue != nil) {
            self.setTop(topValue)
        }

        if (self.leftValue != nil) {
            self.setLeft(leftValue);
        }

        // Executing all kinds of expressions
        if (self.widthValue != nil) {
            self.setWidth(widthValue);
        }

        if (self.heightValue != nil) {
            self.setHeight(heightValue);
        }

        self.layer.frame = CGRect(x: self.left, y: self.top, width: self.width, height: self.height);



    }

    func afterNodeAdded()
    {

    }



    func setStyle(style: VDLElementStyle) {
        for (styleKey, value) in style.styles {
            self.attrs[styleKey] = value;
        }
        for (styleKey, value) in style.styles {
            self.proccessStyle(styleKey, value: value)
        }
        self.stylesAttached();
    }
}