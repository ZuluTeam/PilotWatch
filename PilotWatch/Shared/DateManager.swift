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
    
    private init() {}
    
    private let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        return dateFormatter
    }()
    
    func string(from date: Date) -> String {
        return dateFormatter.string(from: date)
    }
}
