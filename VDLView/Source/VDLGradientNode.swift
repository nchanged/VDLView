//
//  VDLGradientNode.swift
//  VDLKitFramework
//
//  Created by Ivan Orlov on 05/02/15.
//  Copyright (c) 2015 Conmio. All rights reserved.
//

import Foundation


class VDLGradientNode : VDLBaseView
{
	var gradientNode : GradientNode!;
	
	override  func onInit() {
		self.gradientNode = self.layer as GradientNode;
		
	}

    override func stylesAttached()
    {
		
        if ( self.gradientFrom != nil && self.gradientTo  != nil ){
            var params = VDLNodeParamaters()
            params.gradientFrom = self.gradientFrom;
            params.gradientTo = self.gradientTo;
            self.gradientNode.setParams(params);
        }
        super.stylesAttached();
    }
}