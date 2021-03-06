//
//  InterfaceController.swift
//  WatchCheck Extension
//
//  Created by BK on 1/2/16.
//  Copyright © 2016 Bokang Huang. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity

class InterfaceController: WKInterfaceController {

    @IBOutlet var totalLabel: WKInterfaceLabel!
    @IBOutlet var windowLabel: WKInterfaceLabel!
    @IBOutlet var macLabel: WKInterfaceLabel!
    @IBOutlet var linuxLabel: WKInterfaceLabel!
	@IBOutlet var segueButton: WKInterfaceButton!
	
	var buildingModels:[BuildingModel] = []
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
        WCSession.defaultSession().delegate = self
		WCSession.defaultSession().activateSession()
		
		// "Hide" the labels
		self.totalLabel.setAlpha(0)
		self.windowLabel.setAlpha(0)
		self.macLabel.setAlpha(0)
		self.linuxLabel.setAlpha(0)
		
		var totalAvails = 0
		var totalWin = 0
		var totalMac = 0
		var totalLinux = 0
		// Request latest data from ios
		WCSession.defaultSession().sendMessage(["data": "haha"], replyHandler: { (response) -> Void in
			if let data = response["data"] as? NSArray {
				// Map to models
				for dict in data {
					let buildingModel = BuildingModel(dictionary: dict as! NSDictionary)
					// total avails
					totalAvails += buildingModel.nAvailable
					totalWin += buildingModel.nWindows
					totalMac += buildingModel.nMacintosh
					totalLinux += buildingModel.nLinux
					self.buildingModels.append(buildingModel)
				}
				self.totalLabel.setText("\(totalAvails)")
				self.windowLabel.setText("\(totalWin)")
				self.macLabel.setText("\(totalMac)")
				self.linuxLabel.setText("\(totalLinux)")
				self.animateWithDuration(1.0, animations: { () -> Void in
					self.totalLabel.setAlpha(1)
					self.windowLabel.setAlpha(1)
					self.macLabel.setAlpha(1)
					self.linuxLabel.setAlpha(1)
				})
				self.segueButton.setEnabled(true)
			}
			}, errorHandler: { (error) -> Void in
				print(error)
				self.totalLabel.setText("N/A")
				self.windowLabel.setText("N/A")
				self.macLabel.setText("N/A")
				self.linuxLabel.setText("N/A")
				self.animateWithDuration(1.0, animations: { () -> Void in
					self.totalLabel.setAlpha(1)
					self.windowLabel.setAlpha(1)
					self.macLabel.setAlpha(1)
					self.linuxLabel.setAlpha(1)
				})
				self.segueButton.setEnabled(false)
		})
    }
	
	override func contextForSegueWithIdentifier(segueIdentifier: String) -> AnyObject? {
		if segueIdentifier == "buildingPush" {
			return self.buildingModels
		}
		return nil
	}
	
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
}

extension InterfaceController: WCSessionDelegate {
    
    // MARK: WCSessionDelegate
    internal func session(session: WCSession, didReceiveMessage message: [String : AnyObject]) {
        print(message["data"])
    }
    
}
