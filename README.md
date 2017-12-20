# PlainPing

[![CI Status](http://img.shields.io/travis/naptics/PlainPing.svg?style=flat-square)](https://travis-ci.org/naptics/PlainPing)
[![Version](https://img.shields.io/cocoapods/v/PlainPing.svg?style=flat-square)](http://cocoapods.org/pods/PlainPing)
[![License](https://img.shields.io/cocoapods/l/PlainPing.svg?style=flat-square)](http://cocoapods.org/pods/PlainPing)
[![Platform](https://img.shields.io/cocoapods/p/PlainPing.svg?style=flat-square)](http://cocoapods.org/pods/PlainPing)

A very plain ping interface to ping hostname or address, with swift 4.0. The module uses [SimplePing](https://developer.apple.com/library/mac/samplecode/SimplePing/Introduction/Intro.html).

*To use the swift 2.2 version, select the PlainPing 0.2.2 tagged source or pod.*

## Usage

To run the example project, clone the repo, and run `pod install` in the Example directory first.

### PlainPing interface

There is one class function in PlainPing, call `PlainPing.ping(hostname, completionBlock)`.
Arguments:
* `hostName`: use a name or an IP
* `completionBlock`: will return the elapsed time in ms and an error, if there is one
* `withTimeout`: (optional), define how long we wait for an answer in seconds, default 3s


#### Example:
```swift
PlainPing.ping("www.google.com", withTimeout: 1.0, completionBlock: { (timeElapsed:Double?, error:Error?) in
    if let latency = timeElapsed {
        self.pingResultLabel.text = "latency (ms): \(latency)"
    }

    if let error = error {
        print("error: \(error.localizedDescription)")
    }
})
```

#### Example 2:
Ping several hosts one-by-one.
```swift
var pings:[String] = []

@IBAction func pingButtonPressed(_ sender: UIButton) {
    pings = ["www.google.com", "www.naptics.ch"]
    pingNext()
}

func pingNext() {
    guard pings.count > 0 else {
        return
    }

    let ping = pings.removeFirst()
    PlainPing.ping(ping, withTimeout: 1.0, completionBlock: { (timeElapsed:Double?, error:Error?) in
        if let latency = timeElapsed {
            print("\(ping) latency (ms): \(latency)")
        }
        if let error = error {
            print("error: \(error.localizedDescription)")
        }
        self.pingNext()
    })
}
```

## Requirements

Minimum requirements unknown. Tested with the following:
* xcode 9.0
* CocoaPods 1.0

## Installation

PlainPing is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "PlainPing"
```



## Author

Jonas Schoch, jonas.schoch@naptics.ch

## License

PlainPing is available under the MIT license. See the LICENSE file for more info.
