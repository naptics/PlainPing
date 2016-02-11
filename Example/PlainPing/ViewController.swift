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

    var plainPing : PlainPing!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        plainPing = PlainPing()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func pingButtonPressed(sender: UIButton) {
        plainPing.ping("192.168.1.11", completionBlock: { (timeElapsed:Int?) in
            print("bla")
        })
    }
}

