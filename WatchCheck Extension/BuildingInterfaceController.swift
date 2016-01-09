//
//  BuildingInterfaceController.swift
//  ComputerAvailCheck
//
//  Created by BK on 1/9/16.
//  Copyright © 2016 Bokang Huang. All rights reserved.
//

import WatchKit
import Foundation

class BuildingInterfaceController: WKInterfaceController {

	@IBOutlet var buildingTable: WKInterfaceTable!
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
		
        // Configure interface objects here.
		if let buildings = context as? NSArray {
			buildingTable.setNumberOfRows(buildings.count, withRowType: "BuildingRow")
			for index in 0..<buildingTable.numberOfRows {
				if let controller = buildingTable.rowControllerAtIndex(index) as? BuildingRow {
					controller.buildingRow = buildings[index] as? BuildingModel
				}
			}
		}
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
