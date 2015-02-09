//
//  ViewController.swift
//  VDLView
//
//  Created by Ivan Orlov on 09/02/15.
//  Copyright (c) 2015 Ivan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		
		var defaultValues = VDLDefaultValues();
		defaultValues.addValue("header", value:  "Test");
		
		var world = VDLBuilder.inflate("test2", size : self.view.frame.size, values : defaultValues);
		world.rootNode.layerBacked = false;
		self.view.addSubview(world.rootNode.view);
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}


}

