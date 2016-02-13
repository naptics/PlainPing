//
//  SimplePingAdapter.swift
//  Pods
//
//  Created by Jonas Schoch on 11.02.16.
//
//

import Foundation

protocol SimplePingAdapterDelegate {
    func didSendPing()
    func didReceivePong()
    func didFailPingWithError(error: NSError)
}

class SimplePingAdapter: NSObject, SimplePingDelegate {
    
    var delegate:SimplePingAdapterDelegate?
    
    private var pinger:SimplePing!
    private var timeoutTimer:NSTimer?
    private var timeoutDuration:NSTimeInterval = 3

    func startPing(hostName: String, timeout:NSTimeInterval = 3) {
        timeoutDuration = timeout
        
        pinger = SimplePing(hostName: hostName)
        pinger.delegate = self
        pinger.start()
    }
    
    func stopPinging() {
        if let pinger = pinger {
            pinger.stop()
        }
        
        if timeoutTimer != nil {
            timeoutTimer?.invalidate()
            timeoutTimer = nil
        }
    }
    
    func timeout() {
        let userInfo: [NSObject : AnyObject] =
        [
            NSLocalizedDescriptionKey :  NSLocalizedString("ping timed out", value: "Hostname or address not reachable, or network is powered off", comment: ""),
            NSLocalizedFailureReasonErrorKey : NSLocalizedString("ping timed out", value: "Please check the hostname or the address", comment: "")
        ]
        let err = NSError(domain: "PlainPingErrorDomain", code: -100, userInfo: userInfo)
        
        delegate?.didFailPingWithError(err)
        stopPinging()
    }
    
    // MARK: - Simple Ping Delegates
    
    func simplePing(pinger: SimplePing!, didStartWithAddress address: NSData!) {
        timeoutTimer = NSTimer.scheduledTimerWithTimeInterval(timeoutDuration, target: self, selector: "timeout", userInfo: nil, repeats: false)
        pinger.sendPingWithData(nil)
    }
    
    func simplePing(pinger: SimplePing!, didSendPacket packet: NSData!) {
        delegate?.didSendPing()
    }
    
    func simplePing(pinger: SimplePing!, didReceivePingResponsePacket packet: NSData!) {
        delegate?.didReceivePong()
        stopPinging()
    }
    
    func simplePing(pinger: SimplePing!, didReceiveUnexpectedPacket packet: NSData!) {
        stopPinging()
    }
    
    func simplePing(pinger: SimplePing!, didFailToSendPacket packet: NSData!, error: NSError!) {
        delegate?.didFailPingWithError(error)
        stopPinging()
    }
    
    func simplePing(pinger: SimplePing!, didFailWithError error: NSError!) {
        delegate?.didFailPingWithError(error)
        stopPinging()
    }
}