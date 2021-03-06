//
//  BuildingAnnotation.swift
//  ComputerAvailCheck
//
//  Created by BK on 10/5/15.
//  Copyright © 2015 Bokang Huang. All rights reserved.
//

import UIKit
import EVReflection

class BuildingAnnotation: EVObject {
    var name: String = ""
    var latitude: Double = 0
    var longitude: Double = 0
    var buildingModel: BuildingModel!
}
