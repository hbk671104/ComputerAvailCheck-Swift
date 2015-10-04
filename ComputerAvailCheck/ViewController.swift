//
//  ViewController.swift
//  ComputerAvailCheck
//
//  Created by BK on 10/4/15.
//  Copyright © 2015 Bokang Huang. All rights reserved.
//

import UIKit

class ViewController: UIViewController, SOAPEngineDelegate {

	let asmxURL = "https://clc.its.psu.edu/ComputerAvailabilityWS/Service.asmx"
	let buildingSoapAction = "https://clc.its.psu.edu/ComputerAvailabilityWS/Service.asmx/Buildings"
	let roomSoapAction = "https://clc.its.psu.edu/ComputerAvailabilityWS/Service.asmx/Rooms"
		
	var soapManager = SoapManager()
	var buildingModelArray: NSMutableArray = []
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		
		// Soap manager init
		soapManager.delegate = self
		
		// Make a request
		soapManager.requestURL(asmxURL, soapAction: buildingSoapAction, value: "UP", forKey: "Campus")
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	// MARK: SOAPEngineDelegate
	
	func soapEngine(soapEngine: SOAPEngine!, didFinishLoading stringXML: String!, dictionary dict: [NSObject : AnyObject]!) {
		let responseDict = dict as Dictionary
		// Optional Chaining
		if let diffgram = responseDict["diffgram"] {
			if let documentElement = (diffgram as! NSDictionary)["DocumentElement"] {
				if let buildings: NSArray = ((documentElement as! NSDictionary)["Buildings"] as! NSArray) {
					for dict in buildings {
						let buildingModel = BuildingModel(dictionary: dict as! NSDictionary)
						buildingModelArray.addObject(buildingModel)
					}
				}
			}
		}
	}
}

