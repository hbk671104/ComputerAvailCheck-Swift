//
//  ViewController.swift
//  ComputerAvailCheck
//
//  Created by BK on 10/4/15.
//  Copyright © 2015 Bokang Huang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		
		let soap = SOAPEngine()
		soap.userAgent = "SOAPEngine"
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}


}

