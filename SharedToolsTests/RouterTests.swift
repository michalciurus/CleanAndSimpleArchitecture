//  Created by Michal Ciurus

import XCTest
@testable import SharedTools

class RouterTests: XCTestCase {
    
    class MockRouter: Routable {
        
        var didFinishRouting = EventObservable<Void>()
        
        func start() {
            
        }
        
        func finished() {
            didFinishRouting.fireEvent()
        }
    }
    
    func testRouterCollection() {
        let router = MockRouter()
        let routerCollection = RouterCollection()
        
        routerCollection.add(router: router)
        
        XCTAssert(routerCollection.routers.count == 1)
        
        router.finished()
        
        XCTAssert(routerCollection.routers.count == 0)
    }
    
}
