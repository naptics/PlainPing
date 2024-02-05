//
//  PlainPing.swift
//  Pods
//
//  Created by Jonas Schoch on 11.02.16.
//
//

import Foundation

open class PlainPing: SimplePingAdapterDelegate {
    
    fileprivate var pingStartTime: TimeInterval = 0
    fileprivate var pingAdapter:SimplePingAdapter!
    
    /// completion of a ping
    public typealias PlainPingCompletion = (_ elapsedTimeMs: Double?, _ error:Error?) -> ()
    fileprivate var completionBlock: PlainPingCompletion!
    
    // MARK: - main work
    
    /**
        perform a single ping to a given `hostName`
    
        - parameter hostName: a hostname (www.apple.com) or an IP-Address
        - parameter timeout: (optional, default 3) time in seconds to wait for an answer
        - parameter completionBlock: getting called after the ping request has finished or failed
    */
    open class func ping(_ hostName:String, withTimeout timeout:TimeInterval = 3, completionBlock: @escaping PlainPingCompletion) {
        let plainPing = PlainPing()
        plainPing.pingAdapter = SimplePingAdapter()
        plainPing.pingAdapter.delegate = plainPing
        plainPing.completionBlock = completionBlock
        
        plainPing.pingAdapter.startPing(hostName, timeout: timeout)
    }
    
    fileprivate func finalizePing(_ latency:TimeInterval? = nil, error:Error? = nil) {
        if let latency = latency {
            let elapsedTimeMs = latency*1000
            self.completionBlock?(elapsedTimeMs, error)
        } else {
            self.completionBlock?(nil, error)
        }
        pingAdapter.delegate = nil
        pingAdapter = nil
    }
    
    // MARK: - Simple Ping Adapter Delegate
    
    func didSendPing() {
        pingStartTime = Date.timeIntervalSinceReferenceDate
    }
    
    func didReceivePong() {
        let latency = Date.timeIntervalSinceReferenceDate - pingStartTime
        finalizePing(latency)
    }
    
    func didFailPingWithError(_ error: Error) {
        finalizePing(error:error)
    }
}
