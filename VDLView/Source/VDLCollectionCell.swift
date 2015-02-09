//
//  VDLCollectionCell.swift
//  VDLKitFramework
//
//  Created by Ivan Orlov on 06/02/15.
//  Copyright (c) 2015 Conmio. All rights reserved.
//

import Foundation
import UIKit;

@objc class VDLCollectionCell : UICollectionViewCell
{
	var containerNode : ASDisplayNode!;
	var placeholder : UIView!;
	var operation : NSOperation!;
	var actInd : UIActivityIndicatorView!;
	var locked = false;
	
	override init(frame: CGRect) {
		super.init(frame: frame);
		setupViews();
	}

	required init(coder aDecoder: NSCoder) {
	    fatalError("init(coder:) has not been implemented")
		setupViews();
	}
	
	
	override func prepareForReuse() {
		super.prepareForReuse();
		
		// All operation currently in progressed should be dismissed
		cancelOperation();
		
		// Cleaning up current nodoes
		if let v = self.containerNode {
			v.view.removeFromSuperview();
			v.removeFromSupernode();
		}
	}
	
	func cancelOperation()
	{
		if let oldOperation = operation {
			oldOperation.cancel();
		}
	}
	
	func initializePlaceholder() -> UIView!
	{
		actInd = UIActivityIndicatorView();
		actInd.frame = CGRectMake(0.0, 0.0, 40.0, 40.0);
		actInd.center = self.contentView.center;
		actInd.hidesWhenStopped = true
		actInd.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.WhiteLarge;
		return actInd;
	}
	
	func hidePlaceholder()
	{
		if let a = actInd {
			actInd.stopAnimating();
			actInd.hidden = true;
		}
	}
	
	func showPlaceholder()
	{
		if let a = actInd {
			actInd.startAnimating();
			actInd.hidden = false;
		}
	}
	
	// Setup views
	// Used for setup placeholders and other elements that can be re-used
	func setupViews()
	{
		var ph = initializePlaceholder();
		self.contentView.addSubview(ph);
	}
	
	func setupDefaultValues(values : VDLDefaultValues)
	{
		
	}
	
	func setupLayout(creator : VDLCreator)
	{
		
	}
	
	
	func loadViewAsynchronously(viewName : String, queue : NSOperationQueue!)
	{
		cancelOperation();
		showPlaceholder();
		
		operation = NSOperation();
		
		var weakSelf = self;
		operation.completionBlock = {
			if weakSelf.containerNode != nil || weakSelf.locked == true {
				return;
			}
			weakSelf.locked = true;
			
			var values = VDLDefaultValues();
			weakSelf.setupDefaultValues(values);
			
			var world = VDLBuilder.inflate(viewName, size: weakSelf.contentView.frame.size, values: values);
			weakSelf.setupLayout(world.creator);
			
			dispatch_async(dispatch_get_main_queue(), {
				world.rootNode.layerBacked = false;
				world.rootNode.view.alpha = 0;
				
				weakSelf.contentView.addSubview(world.rootNode.view);
				weakSelf.contentView.bringSubviewToFront(weakSelf.placeholder);
				
				// Animate views for smooth transition
				UIView.animateWithDuration(1.0,
					delay: 0.0,
					options: .CurveEaseInOut | .AllowUserInteraction,
					animations: {
						world.rootNode.view.alpha = 1;
						weakSelf.placeholder.alpha = 0;
					}, completion : { finished in
						weakSelf.hidePlaceholder();
					});
				weakSelf.containerNode = world.rootNode;
				weakSelf.locked = false;
			});
		}
		
		queue.addOperation(operation);

		
	}
}
