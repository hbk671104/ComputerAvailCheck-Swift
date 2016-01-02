//
//  RoomViewController.swift
//  ComputerAvailCheck
//
//  Created by BK on 10/5/15.
//  Copyright © 2015 Bokang Huang. All rights reserved.
//

import UIKit
import AMScrollingNavbar
import Whisper

class RoomViewController: UIViewController, SOAPEngineDelegate {

	let asmxURL = "https://clc.its.psu.edu/ComputerAvailabilityWS/Service.asmx"
	let roomSoapAction = "https://clc.its.psu.edu/ComputerAvailabilityWS/Service.asmx/Rooms"
	
	var oppCode: String = ""
	var buildingName: String = ""
	
	@IBOutlet weak var roomTableView: UITableView!
	var refreshControl = UIRefreshControl()
	
	var roomModelArray: [RoomModel] = []
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = self.buildingName
		
		// Add refresh control
		self.refreshControl.tintColor = UIColor.whiteColor()
		self.refreshControl.addTarget(self, action: "loadRoomData", forControlEvents: UIControlEvents.ValueChanged)
		self.roomTableView.contentOffset = CGPointMake(0, -self.refreshControl.frame.size.height)
		self.roomTableView.addSubview(self.refreshControl)
		
		// Make a request
		self.refreshControl.beginRefreshing()
		self.loadRoomData()
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
		SOAPEngine.sharedInstance().delegate = self
        if let navigationController = self.navigationController as? ScrollingNavigationController {
            navigationController.followScrollView(self.roomTableView)
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        if let navigationController = self.navigationController as? ScrollingNavigationController {
            navigationController.stopFollowingScrollView()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
	// MARK: Instance Method
	
	func loadRoomData() {
		SOAPEngine.sharedInstance().clearValues()
		SOAPEngine.sharedInstance().requestURL(asmxURL, soapAction: roomSoapAction, value: self.oppCode, forKey: "OppCode")
	}
	
	func cleanData() {
		self.roomModelArray.removeAll()
	}
	
	// MARK: SOAPEngineDelegate
	
	func soapEngine(soapEngine: SOAPEngine!, didFinishLoading stringXML: String!, dictionary dict: [NSObject : AnyObject]!) {
		self.cleanData()
		let responseDict = dict as Dictionary
		// Optional Chaining
		if let diffgram = responseDict["diffgram"] {
			if let documentElement = (diffgram as! NSDictionary)["DocumentElement"] {
				let rooms = (documentElement as! NSDictionary)["Rooms"]
				if rooms is NSArray {
					for dict in rooms as! NSArray {
						let roomModel = RoomModel(dictionary: dict as! NSDictionary)
						self.roomModelArray.append(roomModel)
					}
				} else {
					let roomModel = RoomModel(dictionary: rooms as! NSDictionary)
					self.roomModelArray.append(roomModel)
				}
				// Refresh tableview
				self.roomTableView.reloadData()
			}
		}
		self.refreshControl.endRefreshing()
	}
	
	func soapEngine(soapEngine: SOAPEngine!, didFailWithError error: NSError!) {
		let message = Murmur(title: error.localizedDescription)
		Whistle(message)
		self.refreshControl.endRefreshing()
	}
	
	// MARK: UITableViewDataSource
	
	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self.roomModelArray.count
	}
	
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let tableViewCell: RoomTableViewCell = tableView.dequeueReusableCellWithIdentifier("roomCell", forIndexPath: indexPath) as! RoomTableViewCell
		
		// Set model
		tableViewCell.roomModel = self.roomModelArray[indexPath.row]
		return tableViewCell
	}
	
	// MARK: UITableViewDelegate
	
	func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		let headerView: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("roomSectionHeader") as UITableViewCell!
		
		return headerView
	}
	
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
