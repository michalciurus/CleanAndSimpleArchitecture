//
//  CreateBoxInteractorTests.swift
//  BoxLogicTests
//
//  Created by Michal Ciurus on 15/04/2018.
//  Copyright © 2018 michalciurus. All rights reserved.
//

import XCTest
@testable import BoxLogic

/// Integration tests for Create box interactor + presenter
class CreateBoxInteratorTests: XCTestCase {
    var createBoxInteractor: CreateBoxInteractor!
    var mockAPI: BoxAPIMock!
    
    override func setUp() {
        mockAPI = BoxAPIMock()
        createBoxInteractor = CreateBoxInteractor(boxAPI: mockAPI)
    }
    
    func testCreatingBox() {
        createBoxInteractor.createBox(key: "temperature", scope: 1)
        XCTAssertTrue(mockAPI.calledCreateBox)
        XCTAssertTrue(mockAPI.lastScope == .user)
    }
}
