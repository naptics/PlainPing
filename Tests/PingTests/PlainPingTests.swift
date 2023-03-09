import XCTest
import PlainPing

final class PlainPingTests: XCTestCase {
    
    func testIt() {
        PlainPing.ping("10", withTimeout: 10, completionBlock: { _, _  in })
    }
}
