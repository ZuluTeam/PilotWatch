//
//  TimeController.swift
//  PilotWatch WatchKit Extension
//
//  Created by Konstantin Zyrianov on 2019-10-28.
//  Copyright © 2019 Zuluteam. All rights reserved.
//

import SwiftUI
import WatchKit

final class TimeController : WKHostingController<TimeView> {
    private var timeModel: TimeModel!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        guard let timeModel = context as? TimeModel else {
            fatalError("context is not a date")
        }
        self.timeModel = timeModel
    }
    
    override var body: TimeView {
        return TimeView(model: timeModel)
    }
}
