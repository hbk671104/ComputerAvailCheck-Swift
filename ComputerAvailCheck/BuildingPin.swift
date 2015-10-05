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
    var annotation: BuildingAnnotation! {
        didSet {
            self.coordinate = CLLocationCoordinate2DMake(annotation.longitude, annotation.latitude)
            self.title = annotation.name
        }
    }
}
