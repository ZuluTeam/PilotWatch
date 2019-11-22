//
//  TimeModel.swift
//  PilotWatch
//
//  Created by Konstantin Zyrianov on 2019-10-24.
//  Copyright © 2019 Zuluteam. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

final class TimeModel: ObservableObject {
    let objectWillChange = ObservableObjectPublisher()
    
    let blockOffTime: Date
    let endurance: TimeInterval
    
    var takeOffTime: Date? {
        willSet {
            objectWillChange.send()
        }
    }
    var landingTime: Date? {
        willSet {
            objectWillChange.send()
        }
    }
    var blockOnTime: Date? {
        willSet {
            objectWillChange.send()
        }
    }
    
    init(blockOffTime: Date, endurance: TimeInterval) {
        self.blockOffTime = blockOffTime
        self.endurance = endurance
    }
}
