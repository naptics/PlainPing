//
//  ViewController.swift
//  PlainPing
//
//  Created by Jonas Schoch on 02/11/2016.
//  Copyright (c) 2016 Jonas Schoch. All rights reserved.
//

import UIKit
import PlainPing

class ViewController: UIViewController {
    
    @IBOutlet weak var pingResultLabel: UILabel!
    

    @IBAction func pingButtonPressed(sender: UIButton) {
        
        PlainPing.ping("192.168.1.11", completionBlock: { (timeElapsed:Double?, error:NSError?) in
            if let latency = timeElapsed {
                self.pingResultLabel.text = "latency: \(latency)"
            }
        })
        
    }
}

