//
//  SoapManager.swift
//  ComputerAvailCheck
//
//  Created by BK on 10/4/15.
//  Copyright © 2015 Bokang Huang. All rights reserved.
//

import UIKit

class SoapManager: SOAPEngine {
	override init() {
		super.init()
		self.version = VERSION_1_2
		self.licenseKey = "i4P459CjYnQ2MV09N4/4V/KbVsU4iiLBG9BOvDWAq0HNFTcJGvD1wmGNzHtI6XA6H+x8shUCOcRlrsaJ+3L0bQ=="
	}
}
