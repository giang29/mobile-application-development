//
//  assignment1Tests.swift
//  assignment1Tests
//
//  Created by Giang Pham on 02/04/2019.
//  Copyright © 2019 Giang Pham. All rights reserved.
//

import XCTest
@testable import assignment1

class TelevisionTests: XCTestCase {
    let tv = TV(channelCount: 8)
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testInitOff() {
        XCTAssert(!tv.on)
    }
    
    func testInitOn() {
        tv.pressOnOff()
        XCTAssert(tv.on)
    }
    
    func testInitChannelOff() {
        XCTAssert(tv.channel == nil)
    }
    
    func testInitVolumeOff() {
        XCTAssert(tv.volume == nil)
    }
    
    func testInitVolumeOn() {
        tv.pressOnOff()
        XCTAssert(tv.volume! == 5)
    }
    
    func testInitChannelOn() {
        tv.pressOnOff()
        XCTAssert(tv.channel! == 1)
    }
    
    func testVolumeUp() {
        tv.pressOnOff()
        let v1 = tv.volume!
        tv.volumeUp()
        XCTAssert(v1 + 1 == tv.volume!)
    }
    
    func testVolumeDown() {
        tv.pressOnOff()
        let v1 = tv.volume!
        tv.volumeDown()
        XCTAssert(v1 - 1 == tv.volume!)
    }
    
    func testVolumeLimitUp() {
        tv.pressOnOff()
        for _ in 1...15 {
            tv.volumeUp()
        }
        XCTAssert(tv.volume! == 10)
    }
    
    func testVolumeLimitDown() {
        tv.pressOnOff()
        for _ in 1...15 {
            tv.volumeDown()
        }
        XCTAssert(tv.volume! == 0)
    }
    
    func testChannelLimitUp() {
        tv.pressOnOff()
        for _ in 1...12 {
            tv.channelUp()
        }
        XCTAssert(tv.channel! == 5)
    }
    
    func testChannelLimitDown() {
        tv.pressOnOff()
        for _ in 1...12 {
            tv.channelDown()
        }
        XCTAssert(tv.channel! == 5)
    }
    
    
}
