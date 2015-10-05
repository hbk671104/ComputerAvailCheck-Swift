//
//  ViewController.swift
//  ComputerAvailCheck
//
//  Created by BK on 10/4/15.
//  Copyright © 2015 Bokang Huang. All rights reserved.
//

import UIKit
import MapKit
import SVProgressHUD

class ViewController: UIViewController, SOAPEngineDelegate {

	let asmxURL = "https://clc.its.psu.edu/ComputerAvailabilityWS/Service.asmx"
	let buildingSoapAction = "https://clc.its.psu.edu/ComputerAvailabilityWS/Service.asmx/Buildings"
	let roomSoapAction = "https://clc.its.psu.edu/ComputerAvailabilityWS/Service.asmx/Rooms"
    let initialLocation = CLLocationCoordinate2D(latitude: 40.799870, longitude: -77.863642)
    
    @IBOutlet weak var buildingMapView: MKMapView!
	@IBOutlet weak var buildingTableView: UITableView!
    var refreshControl = UIRefreshControl()
    
	var soapManager = SoapManager()
	var buildingModelArray: [BuildingModel] = []
    var buildingPinArray: [BuildingPin] = []
    
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

        // Center map
        let region = MKCoordinateRegionMakeWithDistance(self.initialLocation, 800, 800)
        self.buildingMapView.region = region
        
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
		self.buildingModelArray.removeAll()
        self.buildingMapView.removeAnnotations(self.buildingPinArray)
        self.buildingPinArray.removeAll()
		self.soapManager.requestURL(asmxURL, soapAction: buildingSoapAction, value: "UP", forKey: "Campus")
	}
	
    func jsonArrayFromFile(filename: String) -> NSArray {
        let jsonData = NSData(contentsOfFile: filename)
        do {
            let jsonDict: NSDictionary = try NSJSONSerialization.JSONObjectWithData(jsonData!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
            return jsonDict["buildingData"] as! NSArray
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        return []
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
                    // Read json file
                    let fileName = NSBundle.mainBundle().pathForResource("BuildingData", ofType: "json")
                    let jsonArray: NSArray = self.jsonArrayFromFile(fileName!)
                    let buildingNameArray: NSMutableArray = []
                    for dict in jsonArray {
                        buildingNameArray.addObject(dict["name"] as! NSString)
                    }
                    
                    for dict in buildings {
                        let buildingModel = BuildingModel(dictionary: dict as! NSDictionary)
                        // Add available building
                        if buildingNameArray.containsObject(buildingModel.Building) {
                            // Building model
                            self.buildingModelArray.append(buildingModel)
                            
                            // Building pin
                            let index = buildingNameArray.indexOfObject(buildingModel.Building)
                            let targetBuildingDict = jsonArray[index] as! NSDictionary
                            let buildingAnnotation = BuildingAnnotation(dictionary: targetBuildingDict)
                            buildingAnnotation.buildingModel = buildingModel
                            let buildingPin = BuildingPin()
                            buildingPin.annotation = buildingAnnotation
                            self.buildingPinArray.append(buildingPin)
                        }
                    }
                    // Refresh tableview
                    self.buildingTableView.reloadData()
                    // Add annotations
                    self.buildingMapView.addAnnotations(self.buildingPinArray)
				}
			}
		}
	}
	
    func soapEngine(soapEngine: SOAPEngine!, didFailWithError error: NSError!) {
        self.refreshControl.endRefreshing()
        SVProgressHUD.showErrorWithStatus(error.localizedDescription)
    }
    
	// MARK: UITableViewDataSource
	
	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self.buildingModelArray.count
	}
	
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let tableViewCell: BuildingTableViewCell = tableView.dequeueReusableCellWithIdentifier("buildingCell", forIndexPath: indexPath) as! BuildingTableViewCell
		
		// Set model
		tableViewCell.buildingModel = self.buildingModelArray[indexPath.row]
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
    
    // MARK: MKMapViewDelegate
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        if let annotation = annotation as? BuildingPin {
            let identifier = "pin"
            var view: MKPinAnnotationView
            if let dequeuedView = mapView.dequeueReusableAnnotationViewWithIdentifier(identifier)
                as? MKPinAnnotationView {
                dequeuedView.annotation = annotation
                view = dequeuedView
            } else {
                view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                view.animatesDrop = true
                view.canShowCallout = true
                view.rightCalloutAccessoryView = UIButton(type:.DetailDisclosure)
            }
            
            // Set color based on availability ratio
            let index = self.buildingPinArray.indexOf(annotation)
            let buildingModel = self.buildingModelArray[index!]
            if buildingModel.nAvailable < buildingModel.nComputers / 2 {
                view.pinColor = .Red
            } else {
                view.pinColor = .Green
            }
            return view
        }
        return nil
    }
    
    func mapView(mapView: MKMapView, didSelectAnnotationView view: MKAnnotationView) {
        let pin = view.annotation as! BuildingPin
        let index = self.buildingPinArray.indexOf(pin)
        let indexPath = NSIndexPath(forRow: index!, inSection: 0)
        self.buildingTableView.scrollToRowAtIndexPath(indexPath, atScrollPosition: .Top, animated: true)
    }
    
}

