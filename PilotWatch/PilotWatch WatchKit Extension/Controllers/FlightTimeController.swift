//
//  FlightTimeController.swift
//  PilotWatch WatchKit Extension
//
//  Created by Konstantin Zyrianov on 2019-10-30.
//  Copyright © 2019 Zuluteam. All rights reserved.
//

import Foundation
import WatchKit
import SwiftUI

final class FlightTimeController: WKHostingController<FlightTimeView> {
    override var body: FlightTimeView {
        return FlightTimeView()
    }
}
