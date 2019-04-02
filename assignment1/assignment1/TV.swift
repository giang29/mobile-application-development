//
//  TV.swift
//  assignment1
//
//  Created by Giang Pham on 02/04/2019.
//  Copyright © 2019 Giang Pham. All rights reserved.
//

import Foundation

class TV {
    private(set) var on = false
    private let channelCount: Int
    private(set) var channel: Int? = nil
    private(set) var volume: Int? = nil
    init(channelCount: Int) {
        self.channelCount = channelCount
    }
    
    func pressOnOff() {
        on = !on
        if (on) {
            channel = 1
            volume = 5
        } else {
            channel = nil
            volume = nil
        }
    }
    
    func volumeUp() {
        if let vol = volume, vol < 10 {
            volume = vol + 1
        }
    }
    
    func volumeDown() {
        if let vol = volume, vol > 0 {
            volume = vol - 1
        }
    }
    
    func channelUp() {
        if let channel = channel {
            if (channel + 1 > channelCount) {
                self.channel = channel + 1 - channelCount
            } else {
                self.channel = channel + 1
            }
        }
    }
    
    func channelDown() {
        if let channel = channel {
            if (channel - 1 <= 0) {
                self.channel = channel - 1 + channelCount
            } else {
                self.channel = channel - 1
            }
        }
    }
}
