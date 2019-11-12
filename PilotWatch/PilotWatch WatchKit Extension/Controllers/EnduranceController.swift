//
//  EnduranceController.swift
//  PilotWatch WatchKit Extension
//
//  Created by Konstantin Zyrianov on 2019-07-31.
//  Copyright © 2019 Zuluteam. All rights reserved.
//

import WatchKit
import Foundation
import SwiftUI

final class EnduranceController : WKHostingController<EnduranceView> {
    override var body: EnduranceView {
        return EnduranceView(host: self)
    }
    
    func startTime(withBlockOffTime blockOffTime: Date, endurance: TimeInterval) {
        let timeModel = TimeModel(blockOffTime: blockOffTime, endurance: endurance)
        UserDefaults.standard.set(endurance, forKey: UserDefaultsKeys.lastEndurance)
        UserDefaults.standard.synchronize()
        
        WKInterfaceController.reloadRootControllers(
            withNamesAndContexts: [("TimeController", timeModel),
                                   ("FlightTimeController", timeModel)])
    }
}
