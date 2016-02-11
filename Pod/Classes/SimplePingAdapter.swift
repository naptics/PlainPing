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
    
    private var pinger:SimplePing!
    var delegate:SimplePingAdapterDelegate?

    func startPing(hostName: String) {
        pinger = SimplePing(hostName: hostName)
        pinger.delegate = self
        pinger.start()
    }
    
    // MARK: - Simple Ping Delegates
    
    func simplePing(pinger: SimplePing!, didStartWithAddress address: NSData!) {
        print("didStartWithAddress \(NSString.init(data: address, encoding: NSUTF8StringEncoding))")
        pinger.sendPingWithData(nil)
    }
    
    func simplePing(pinger: SimplePing!, didSendPacket packet: NSData!) {
        print("didSendPacket")
        delegate?.didSendPing()
    }
    
    func simplePing(pinger: SimplePing!, didReceivePingResponsePacket packet: NSData!) {
        print("didReceivePingResponsePacket")
        delegate?.didReceivePong()
    }
    
    func simplePing(pinger: SimplePing!, didReceiveUnexpectedPacket packet: NSData!) {
        print("didReceiveUnexpactedPacket")
    }
    
    func simplePing(pinger: SimplePing!, didFailToSendPacket packet: NSData!, error: NSError!) {
        print("didFailToSendPacket")
        delegate?.didFailPingWithError(error)
    }
    
    func simplePing(pinger: SimplePing!, didFailWithError error: NSError!) {
        print("didFailWithError")
        delegate?.didFailPingWithError(error)
    }
}