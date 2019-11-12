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
    private var timeModel: TimeModel!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        guard let timeModel = context as? TimeModel else {
            fatalError("context is not a date")
        }
        self.timeModel = timeModel
    }
    
    override var body: FlightTimeView {
        return FlightTimeView(timeModel: timeModel)
    }
}
