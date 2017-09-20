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
    func didFailPingWithError(_ error: Error)
}

class SimplePingAdapter: NSObject, SimplePingDelegate {
    
    var delegate:SimplePingAdapterDelegate?
    
    fileprivate var pinger:SimplePing!
    fileprivate var timeoutTimer:Timer?
    fileprivate var timeoutDuration:TimeInterval = 3

    func startPing(_ hostName: String, timeout:TimeInterval = 3) {
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
    
    @objc func timeout() {
        let userInfo: [String: Any] =
        [
            NSLocalizedDescriptionKey :  NSLocalizedString("ping timed out", value: "Hostname or address not reachable, or network is powered off", comment: ""),
            NSLocalizedFailureReasonErrorKey : NSLocalizedString("ping timed out", value: "Please check the hostname or the address", comment: "")
        ]
        let err = NSError(domain: "PlainPingErrorDomain", code: -100, userInfo: userInfo)
        
        delegate?.didFailPingWithError(err)
        stopPinging()
    }
    
    // MARK: - Simple Ping Delegates
    
    func simplePing(_ pinger: SimplePing, didStartWithAddress address: Data) {
        timeoutTimer = Timer.scheduledTimer(timeInterval: timeoutDuration, target: self, selector: #selector(timeout), userInfo: nil, repeats: false)
        pinger.send(with: nil)
    }
    
    func simplePing(_ pinger: SimplePing, didSendPacket packet: Data, sequenceNumber: UInt16) {
        delegate?.didSendPing()
    }
    
    func simplePing(_ pinger: SimplePing, didReceivePingResponsePacket packet: Data, sequenceNumber: UInt16) {
        delegate?.didReceivePong()
        stopPinging()
    }
    
    func simplePing(_ pinger: SimplePing, didReceiveUnexpectedPacket packet: Data) {
        stopPinging()
    }
    
    func simplePing(_ pinger: SimplePing, didFailToSendPacket packet: Data, sequenceNumber: UInt16, error: Error) {
        delegate?.didFailPingWithError(error)
        stopPinging()
    }
    
    func simplePing(_ pinger: SimplePing, didFailWithError error: Error) {
        delegate?.didFailPingWithError(error)
        stopPinging()
    }
}
