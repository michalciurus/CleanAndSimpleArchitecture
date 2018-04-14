//created by Michal Ciurus

import XCTest
@testable import BoxLogic
import NetworkAPI

class BoxFeedInteractorTests: XCTestCase {
    
    var boxFeedInteractor: BoxFeedInteractor!
    var mockAPI: BoxAPIMock!
    
    override func setUp() {

        mockAPI = BoxAPIMock()
        boxFeedInteractor = BoxFeedInteractor(boxAPI: mockAPI)
    }
    
    func testFetchBoxesPagination() {
        boxFeedInteractor.fetchInitialBoxes()
        XCTAssert(mockAPI.calledGetBoxes)
        XCTAssert(boxFeedInteractor.presenter.boxes.value?.count == 1)
        boxFeedInteractor.fetchMoreBoxes()
        XCTAssert(mockAPI.lastPage == 1)
        boxFeedInteractor.fetchInitialBoxes()
        XCTAssert(mockAPI.lastPage == 0)
    }
    
    func testDelete() {
        boxFeedInteractor.fetchInitialBoxes()
        boxFeedInteractor.deleteBox(at: 0) { success in
            
        }
        XCTAssert(boxFeedInteractor.presenter.boxes.value?.count == 0)
    }
    
}
