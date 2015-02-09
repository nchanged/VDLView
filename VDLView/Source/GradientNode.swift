//
//  GradientNode.swift
//  VDLKitFramework
//
//  Created by Ivan Orlov on 05/02/15.
//  Copyright (c) 2015 Conmio. All rights reserved.
//

import Foundation
import UIKit;

class P: NSObject {
    var name = "PUkka";
}

class GradientNode: ASDisplayNode {

    var customParams: NSObjectProtocol!;

    func setParams(params: NSObjectProtocol) {
        self.customParams = params;
    }

    func drawParameters() -> NSObjectProtocol! {
        return self.customParams;
    }

    class func drawRect(bounds: CGRect, withParameters parameters: NSObjectProtocol!,
                        isCancelled isCancelledBlock: () -> (), isRasterizing: Bool) {


        if (parameters != nil) {

            var params = parameters as VDLNodeParamaters;

            let myContext = UIGraphicsGetCurrentContext()
            CGContextSaveGState(myContext)
            CGContextClipToRect(myContext, bounds)

            let componentCount: UInt = 2
            let locations: [CGFloat] = [0.0, 1.0];


            var from = CGColorGetComponents(params.gradientFrom.CGColor)
            var to = CGColorGetComponents(params.gradientTo.CGColor)


            let components: [CGFloat] = [from[0], from[1], from[2], from[3],
                                         to[0], to[1], to[2], to[3]]
            let myColorSpace = CGColorSpaceCreateDeviceRGB()

            let myGradient = CGGradientCreateWithColorComponents(myColorSpace, components,
                    locations, componentCount)

            let myStartPoint = CGPoint(x: bounds.midX, y: bounds.maxY)
            let myEndPoint = CGPoint(x: bounds.midX, y: bounds.midY)
            CGContextDrawLinearGradient(myContext, myGradient, myStartPoint,
                    myEndPoint, UInt32(kCGGradientDrawsAfterEndLocation))

            CGContextRestoreGState(myContext)
        }
    }


}
