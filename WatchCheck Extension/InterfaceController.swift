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
    var connectivitySession:WCSession? {
        didSet {
            if let session = connectivitySession {
                session.delegate = self
                session.activateSession()
            }
        }
    }
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
        connectivitySession = WCSession.defaultSession()
        // Request latest data
        connectivitySession?.sendMessage(["data": "haha"], replyHandler: { (response) -> Void in
            if let data = response["data"] as? NSArray {
                print(data)
            }
            }, errorHandler: { (error) -> Void in
                print(error)
        })
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
    internal func session(session: WCSession, didReceiveMessage message: [String : AnyObject]) {
        
    }
    
}
