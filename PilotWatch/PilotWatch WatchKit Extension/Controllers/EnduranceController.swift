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
    
    func startTime(withBlockOffTime blockOffTime: Date) {
        WKInterfaceController.reloadRootControllers(withNamesAndContexts: [("TimeController", blockOffTime as AnyObject), ("FlightTimeController", "" as AnyObject)])
    }
}
