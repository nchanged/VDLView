//
//  VDLImageView.swift
//  VDLKitFramework
//
//  Created by Ivan Orlov on 03/02/15.
//  Copyright (c) 2015 Conmio. All rights reserved.
//

import Foundation
import UIKit;


@objc class VDLImageView : VDLBaseView
{
	var imageNode : ASImageNode!;
	
	override func onInit() {
		self.imageNode = self.layer as ASImageNode;
		
	}
	
	var resizeImage : CGSize!
	var cacheImage : Bool = true
	
	
	override func setCache(value: VDLStyleValue) {
		self.cacheImage = true
	}
	
	// Setting resize
	override func setResize(value: VDLStyleValue) {
		var width = Int(value.getFirstAsFloat())
		var height = width
		if value.hasTwoArgs() {
			height = Int(value.getSecondAsFloat())
		}
		self.resizeImage = CGSize(width: width, height: height)
	}
	
	
	override func setImage(value: VDLStyleValue) {
		
		if let cache = self.attrs["cache"] {
			self.cacheImage = true
		}
		
		if let resizeValue = self.attrs["resize"] {
			self.setResize(resizeValue)
		}
		
		
		var imageString = value.getFirstAsString();

		var startsWithHTTP = imageString["^http://.*?"].groups()
		if startsWithHTTP != nil {
			self.loadImage(imageString)
		} else {
			self.imageNode.image = UIImage(named: imageString)
		}
		
	}

    override func setDefaultValue(value: String) {
        self.setImage(VDLStyleValue(fullValue: value));
    }

    func setImageObject(image : UIImage)
    {
        self.imageNode.image = image;
    }

    func setLocalImage(name : String)
    {
        self.imageNode.image = UIImage(named: name);
    }
	
	func loadImage(urlString: String)
	{
		self.loadImage(urlString, completion: { () -> () in
			
		})
	}
	
	func RBResizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
		let size = image.size
		
		let widthRatio  = targetSize.width  / image.size.width
		let heightRatio = targetSize.height / image.size.height
		
		// Figure out what our orientation is, and use that to form the rectangle
		var newSize: CGSize
		if(widthRatio > heightRatio) {
			newSize = CGSizeMake(size.width * heightRatio, size.height * heightRatio)
		} else {
			newSize = CGSizeMake(size.width * widthRatio,  size.height * widthRatio)
		}
		
		// This is the rect that we've calculated out and this is what is actually used below
		let rect = CGRectMake(0, 0, newSize.width, newSize.height)
		
		// Actually do the resizing to the rect using the ImageContext stuff
		UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
		image.drawInRect(rect)
		let newImage = UIGraphicsGetImageFromCurrentImageContext()
		UIGraphicsEndImageContext()
		
		return newImage
	}
	
	
	
	func loadImage(urlString: String,  completion :() -> ())
	{
		
		if ( self.resizeImage == nil){
			self.resizeImage = CGSize(width: self.computeWidth(), height: self.computeHeight());
		}
		

		self.imageNode.contentMode = UIViewContentMode.ScaleAspectFill;
		var imageData : NSData!;
		
		// Creating cache name
		var cacheName = urlString
		
		
		cacheName = "\(urlString)_\(self.resizeImage.width)_\(self.resizeImage.height)_foo23"
		
		cacheName = cacheName.replace("/", withString: "")
		cacheName = cacheName.replace(":", withString: "")
		
		imageData = LocalStorage.getDataFromFileName(cacheName)
		
		
		
		if( imageData == nil || self.cacheImage == false ) {
			// If the image does not exist, we need to download it
			var imgURL: NSURL = NSURL(string: urlString)!
				
			// Download an NSData representation of the image at the URL
			let request: NSURLRequest = NSURLRequest(URL: imgURL)
			NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: {(response: NSURLResponse!,data: NSData!,error: NSError!) -> Void in
				
				if error == nil {
					dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
						var canceled = false;
						
						var image = UIImage(data: data);
						if image != nil && canceled == false {
							image = self.RBResizeImage(image!, targetSize: self.resizeImage)
							var resizedData = UIImagePNGRepresentation(image)
							LocalStorage.saveDataToFileName(cacheName, data: resizedData)
							
							
						
							dispatch_async(dispatch_get_main_queue()) {
								
								if NSThread.isMainThread() {
									self.imageNode.image = image;
								}
								
								completion();
							}
						}
						
						
					});
				}
					
				else {
					println("Error: \(error.localizedDescription)")
					completion();
				}
				
				
			})
		}
		else {
			dispatch_async(dispatch_get_main_queue()) {
				if NSThread.isMainThread() {
					self.imageNode.image = UIImage(data: imageData)
				}
				completion();
			};
			
		}
		
	}
}