//
//  PlainPing.swift
//  Pods
//
//  Created by Jonas Schoch on 11.02.16.
//
//

import Foundation

public class PlainPing: NSObject, SimplePingDelegate {
    
    private var pinger: SimplePing!
    private var pingStartTime: NSTimeInterval = 0
    private var timeOutTimer: NSTimer!
    
    typealias CompletionBlock = (timeElapsedMs: Int?) -> ()
    var completionBlock: CompletionBlock!
    
    public func ping(hostName:String, completionBlock: (timeElapsedMs: Int?) -> ()) {
//        let beYourself = PlainPing()
        pinger = SimplePing(hostName: hostName)
        pinger.delegate = self
        pinger.start()
        print("ping startet")
    }
    
    
    // MARK: - Simple Ping Delegates
    
    public func simplePing(pinger: SimplePing!, didStartWithAddress address: NSData!) {
        print("didStartWithAddress \(NSString.init(data: address, encoding: NSUTF8StringEncoding))")
        pinger.sendPingWithData(nil)
    }
    
    public func simplePing(pinger: SimplePing!, didSendPacket packet: NSData!) {
        print("didSendPacket")
    }
    
    public func simplePing(pinger: SimplePing!, didReceivePingResponsePacket packet: NSData!) {
        print("didReceivePingResponsePacket")
    }
    
    public func simplePing(pinger: SimplePing!, didReceiveUnexpectedPacket packet: NSData!) {
        print("didReceiveUnexpactedPacket")
    }
    
    public func simplePing(pinger: SimplePing!, didFailToSendPacket packet: NSData!, error: NSError!) {
        print("didFailToSendPacket")
    }
    
    public func simplePing(pinger: SimplePing!, didFailWithError error: NSError!) {
        print("didFailWithError")
    }
}