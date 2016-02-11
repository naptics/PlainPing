//
//  PlainPing.swift
//  Pods
//
//  Created by Jonas Schoch on 11.02.16.
//
//

import Foundation

public class PlainPing: SimplePingAdapterDelegate {
    
    private var pingStartTime: NSTimeInterval = 0
    private var timeoutTimer: NSTimer!
    
    private var pingAdapter:SimplePingAdapter!
    
    /// completion of a ping
    public typealias PlainPingCompletion = (elapsedTimeMs: Double?, error:NSError?) -> ()
    var completionBlock: PlainPingCompletion!
    
    // MARK: - main work
    
    /**
        perform a single ping to a given `hostName`
    
        - parameter hostName: a hostname (www.apple.com) or an IP-Address
        - parameter completionBlock: getting called after the ping request has finished or failed
    */
    public class func ping(hostName:String, withTimeout timeout:NSTimeInterval = 3, completionBlock: PlainPingCompletion) {
        let plainPing = PlainPing()
        plainPing.pingAdapter = SimplePingAdapter()
        plainPing.pingAdapter.delegate = plainPing
        plainPing.completionBlock = completionBlock
        
        plainPing.pingAdapter.startPing(hostName, timeout: timeout)
    }
    
    private func finalizePing(latency:NSTimeInterval? = nil, error:NSError? = nil) {
        if let latency = latency {
            let elapsedTimeMs = latency*1000
            self.completionBlock?(elapsedTimeMs: elapsedTimeMs, error: error)
        } else {
            self.completionBlock?(elapsedTimeMs: nil, error: error)
        }
    }
    
    // MARK: - Simple Ping Adapter Delegate
    
    func didSendPing() {
        pingStartTime = NSDate.timeIntervalSinceReferenceDate()
    }
    
    func didReceivePong() {
        let latency = NSDate.timeIntervalSinceReferenceDate() - pingStartTime
        finalizePing(latency)
    }
    
    func didFailPingWithError(error: NSError) {
        finalizePing(error:error)
    }
}