import UIKit
import XCTest
import PlainPing

class Tests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testPingValidUrl() {
        let url = "www.google.com"
        let timeout = 3.0
        
        let readyExpectation = expectationWithDescription("ready")
        
        PlainPing.ping(url, withTimeout: timeout, completionBlock: { (timeElapsed:Double?, error:NSError?) in
            XCTAssertNotNil(timeElapsed)
            XCTAssertLessThanOrEqual(timeElapsed!/1000, timeout)
            XCTAssertNil(error)
            
            readyExpectation.fulfill()
        })
        
        // Loop until the expectation is fulfilled
        waitForExpectationsWithTimeout(5, handler: { error in
            XCTAssertNil(error, "Error")
        })
    }
    
    func testPingInvalidUrl() {
        let url = "192.168.1.432"
        let timeout = 3.0
        
        let readyExpectation = expectationWithDescription("ready")
        
        PlainPing.ping(url, withTimeout: timeout, completionBlock: { (timeElapsed:Double?, error:NSError?) in
            XCTAssertNil(timeElapsed)
            XCTAssertNotNil(error)
            
            readyExpectation.fulfill()
        })
        
        // Loop until the expectation is fulfilled
        waitForExpectationsWithTimeout(5, handler: { error in
            XCTAssertNil(error, "Error")
        })
    }
    
}
