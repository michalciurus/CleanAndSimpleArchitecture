//  Created by Michal Ciurus

import XCTest
@testable import SharedTools

class ObserverTests: XCTestCase {
    
    func testObserving() {
        let valueObservable = ValueObservable(value: 1)
        let eventObservable = EventObservable<Int>()
        let voidObservable = EventObservable<(Void)>()
        
        let valueExp = expectation(description: "Value Observer gets notified")
        let eventExp = expectation(description: "Event Observer gets notified")
        let voidExp = expectation(description: "Void Event Observer gets notified")
        
        valueObservable.observe { (value) in
            XCTAssert(value == 2)
            valueExp.fulfill()
        }
        
        eventObservable.observe { (value) in
            XCTAssert(value == 2)
            eventExp.fulfill()
        }
        
        voidObservable.observe {
            voidExp.fulfill()
        }
        
        valueObservable.value = 2
        eventObservable.fireEvent(with: 2)
        voidObservable.fireEvent()
        
        waitForExpectations(timeout: 1, handler: nil)
    }
    
}
