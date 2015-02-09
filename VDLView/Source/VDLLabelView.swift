//
//  VDLLabelView.swift
//  VDLTest
//
//  Created by Ivan Orlov on 02/02/15.
//  Copyright (c) 2015 Conmio. All rights reserved.
//

import Foundation
import UIKit;


@objc class VDLLabelView: VDLBaseView {
    var textNode: ASTextNode!;
    override func onInit() {
        self.textNode = self.layer as ASTextNode;

    }

    var textBackgroundColor = UIColor.clearColor();
    var textForegroundColor = UIColor.clearColor();
    var textFont = UIFont(name: "Arial", size: 16);
    var textString = "Lorem ipsum";
	var reservedString = "";

    //var textParagraphStyle = NSParagraphStyle.justifiedParagraphStyle();
	
	override func show() {


		stylesAttached();
		
	}
	
	 override func hide() {
	
		self.textNode.attributedString =  NSAttributedString(string: "", attributes: nil);
		

	}
	
    override func setForegroundColor(value: VDLStyleValue) {
        self.textForegroundColor = self.getColor(value);
    }

    override func setTextValue(value: VDLStyleValue) {
        self.textString = value.fullValue;
    }

    override func setDefaultValue(value: String) {
        self.textString = value;
    }


    override func setBackgroundColor(value: VDLStyleValue) {
        self.textBackgroundColor = self.getColor(value)
    }

    override func setFont(value: VDLStyleValue) {
        var size: CGFloat = 16;
        var font = value.getFirstAsString()
        if value.hasTwoArgs() {
            size = value.getSecondAsFloat()
        }
        textFont = UIFont(name: font, size: size)
    }

    override func setAlign(value: VDLStyleValue) {

    }

    override func setColor(value: VDLStyleValue) {
        self.textForegroundColor = self.getColor(value)
    }

    func setText(value: String) {
        self.textString = value;
    }

    override func stylesAttached() {
        var maxWidth: CGFloat = 0;
        if (self.maxWidthValue != nil) {
            maxWidth = maxWidthValue.getFirstAsFloat();
            if (maxWidthValue.expression != nil) {
                maxWidth = self.compileExpression(self.maxWidthValue.expression);
            }
        }


        let descriptionAttributes = [NSFontAttributeName: textFont!,

                                     NSForegroundColorAttributeName: textForegroundColor,
                                     NSBackgroundColorAttributeName: textBackgroundColor,
        ]

        var s = CGSizeMake(maxWidth == 0 ? parent.width : maxWidth, CGFloat(FLT_MAX));

        self.textNode.attributedString = NSAttributedString(string: textString, attributes: descriptionAttributes)

        self.textNode.measure(s);
        self.width = textNode.calculatedSize.width;
        self.height = textNode.calculatedSize.height;

        super.stylesAttached();
    }

}