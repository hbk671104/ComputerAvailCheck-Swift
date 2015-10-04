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
	
	@IBOutlet weak var buildingTableView: UITableView!
    var refreshControl = UIRefreshControl()
    
	var soapManager = SoapManager()
	var buildingModelArray: NSMutableArray = []
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		
		// Soap manager init
		self.soapManager.delegate = self
		
        // Add refresh control
        self.refreshControl.tintColor = UIColor.whiteColor()
        self.refreshControl.addTarget(self, action: "loadBuildingData", forControlEvents: UIControlEvents.ValueChanged)
        self.buildingTableView.contentOffset = CGPointMake(0, -self.refreshControl.frame.size.height)
        self.buildingTableView.addSubview(self.refreshControl)

		// Make a request
		self.refreshControl.beginRefreshing()
        self.loadBuildingData()
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	// MARK: Instance Method
    
	func loadBuildingData() {
		self.soapManager.requestURL(asmxURL, soapAction: buildingSoapAction, value: "UP", forKey: "Campus")
	}
	
	// MARK: SOAPEngineDelegate
	
	func soapEngine(soapEngine: SOAPEngine!, didFinishLoading stringXML: String!, dictionary dict: [NSObject : AnyObject]!) {
        // End refreshing
        self.refreshControl.endRefreshing()
		let responseDict = dict as Dictionary
		// Optional Chaining
		if let diffgram = responseDict["diffgram"] {
			if let documentElement = (diffgram as! NSDictionary)["DocumentElement"] {
				if let buildings: NSArray = ((documentElement as! NSDictionary)["Buildings"] as! NSArray) {
					for dict in buildings {
						let buildingModel = BuildingModel(dictionary: dict as! NSDictionary)
						self.buildingModelArray.addObject(buildingModel)
					}
					self.buildingTableView.reloadData()
				}
			}
		}
	}
	
	// MARK: UITableViewDataSource
	
	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return buildingModelArray.count
	}
	
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let tableViewCell: BuildingTableViewCell = tableView.dequeueReusableCellWithIdentifier("buildingCell", forIndexPath: indexPath) as! BuildingTableViewCell
		
		// Set model
		tableViewCell.buildingModel = buildingModelArray[indexPath.row] as! BuildingModel
		return tableViewCell
	}
    
    // MARK: UITableViewDelegate
	
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("buildingSectionHeader") as UITableViewCell!
        
        return headerView
    }
}

