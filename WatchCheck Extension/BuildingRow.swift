//
//  BuildingRow.swift
//  ComputerAvailCheck
//
//  Created by BK on 1/9/16.
//  Copyright © 2016 Bokang Huang. All rights reserved.
//

import WatchKit

class BuildingRow: NSObject {
	
	@IBOutlet var buildingLabel: WKInterfaceLabel!
	@IBOutlet var winLabel: WKInterfaceLabel!
	@IBOutlet var macLabel: WKInterfaceLabel!
	@IBOutlet var linuxLabel: WKInterfaceLabel!
	
	var buildingRow: BuildingModel? {
		didSet {
			if let building = buildingRow {
				buildingLabel.setText(building.Building)
				winLabel.setText("\(building.nWindows)")
				macLabel.setText("\(building.nMacintosh)")
				linuxLabel.setText("\(building.nLinux)")
			}
		}
	}
}
