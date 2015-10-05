//
//  BuildingPin.swift
//  ComputerAvailCheck
//
//  Created by BK on 10/5/15.
//  Copyright © 2015 Bokang Huang. All rights reserved.
//

import UIKit
import MapKit

class BuildingPin: MKPointAnnotation {
    var annotation: BuildingAnnotation {
        didSet {
            self.coordinate = CLLocationCoordinate2D(latitude: (annotation.latitude as NSString).doubleValue, longitude: (annotation.longitude as NSString).doubleValue)
            self.title = annotation.name
        }
    }
    init(buildingAnnotation: BuildingAnnotation) {
        self.annotation = buildingAnnotation
        super.init()
    }
}
