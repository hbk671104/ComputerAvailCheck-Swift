//
//  BuildingModel.swift
//  ComputerAvailCheck
//
//  Created by BK on 10/4/15.
//  Copyright © 2015 Bokang Huang. All rights reserved.
//

import UIKit
import EVReflection

class BuildingModel: EVObject {
	var Building: String = ""
	var OppCode: String = ""
	var nAvailable: Int = 0
	var nComputers: Int = 0
	var nLinux: Int = 0
	var nMacintosh: Int = 0
	var nRooms: Int = 0
	var nWindows: Int = 0
}
