//
//  String+ExtensionTests.swift
//  web3swift
//
//  Created by Adrian Coroian on 5/30/18.
//  Copyright © 2018 Radical App LLC. All rights reserved.
//

import XCTest
@testable import web3swift

class StringTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testIsHexAddress() {
        let hexAddress = "0xba221f461dcf389c92bbd5c917769e4201fb8395"
        let nonHex = "test"
        XCTAssertEqual(hexAddress.isHexAddress(), true, "isHexAddress should return true for a real hex address")
        XCTAssertEqual(nonHex.isHexAddress(), false, "isHexAddress should return false for a nonhex value")
        // Put the code you want to measure the time of here.
    }
}
