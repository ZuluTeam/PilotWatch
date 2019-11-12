//
//  DateManager.swift
//  PilotWatch
//
//  Created by Konstantin Zyrianov on 2019-10-25.
//  Copyright © 2019 Zuluteam. All rights reserved.
//

import Foundation

final class DateManager {
    static let shared = DateManager()
    
    static let dangerousEndurance: TimeInterval = 60 * 60 // 1 hour
    static let criticalEndurance: TimeInterval = 45 * 60 // 45 minutes
    
    private init() {}
    
    private let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        return dateFormatter
    }()
    
    private let durationFormatter: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.zeroFormattingBehavior = .pad
        formatter.unitsStyle = .positional
        formatter.allowedUnits = [ .hour, .minute, .second ]
        return formatter
    }()
    
    func string(from date: Date) -> String {
        return dateFormatter.string(from: date)
    }
    
    func string(from timeInterval: TimeInterval) -> String {
        return durationFormatter.string(from: timeInterval) ?? "--:--:--"
    }
}
