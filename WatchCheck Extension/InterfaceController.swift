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

    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
        WCSession.defaultSession().delegate = self
        WCSession.defaultSession().activateSession()
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
    internal func session(session: WCSession, didReceiveApplicationContext applicationContext: [String : AnyObject]) {
        print(applicationContext["data"])
    }
    
}
