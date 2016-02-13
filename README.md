# PlainPing

[![CI Status](http://img.shields.io/travis/naptics/PlainPing.svg?style=flat-square)](https://travis-ci.org/naptics/PlainPing)
[![Version](https://img.shields.io/cocoapods/v/PlainPing.svg?style=flat-square)](http://cocoapods.org/pods/PlainPing)
[![License](https://img.shields.io/cocoapods/l/PlainPing.svg?style=flat-square)](http://cocoapods.org/pods/PlainPing)
[![Platform](https://img.shields.io/cocoapods/p/PlainPing.svg?style=flat-square)](http://cocoapods.org/pods/PlainPing)

A very plain ping interface to ping hostname or address, written in swift.

## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.

### PlainPing interface

There is only one function in PlainPing, call `PlainPing.ping(hostname, completionBlock)`.

Example:
```swift
PlainPing.ping("www.google.com", withTimeout: 1.0, completionBlock: { (timeElapsed:Double?, error:NSError?) in
    if let latency = timeElapsed {
        self.pingResultLabel.text = "latency (ms): \(latency)"
    }

    if let error = error {
        print("error: \(error.localizedFailureReason)\(error.localizedDescription)")
    }
})
```
* `hostName`: use a name or an IP
* `completionBlock`: it returns the elapsed time in ms and an error, if available
* `withTimout`: (optional), say how long we wait for an answer in seconds, default 3s


## Requirements

Minimum requirements unknown. Tested with the following:
* xcode 7.2
* CocoaPods 0.39.0 (only if you like)

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
