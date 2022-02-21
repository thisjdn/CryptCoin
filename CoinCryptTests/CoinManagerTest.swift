//
//  CoinManagerTest.swift
//  CoinCryptTests
//
//  Created by Jaden Hong on 2022-02-20.
//

import XCTest
@testable import CoinCrypt

class CoinManagerTest: XCTestCase {

    var sut : CoinManager!
    
    override func setUp() {
        super.setUp()
        sut = CoinManager()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testParseJSON() {
//        given, when, then
        let json = """
        {
          "time": "2022-02-20T00:42:12.1255952Z",
          "asset_id_base": "USD",
          "asset_id_quote": "BTC",
          "rate": 1
        }
        """
        
        let testData = json.data(using: .utf8)!
        let result = sut.parseJSON(data: testData)
        
        XCTAssertNoThrow(result, "XCTAssert Throws Error: parseJSON failed")
    }

}
