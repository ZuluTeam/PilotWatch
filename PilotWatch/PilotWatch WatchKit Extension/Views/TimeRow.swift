//
//  TimeRow.swift
//  PilotWatch WatchKit Extension
//
//  Created by Konstantin Zyrianov on 2019-11-12.
//  Copyright © 2019 Zuluteam. All rights reserved.
//

import SwiftUI

struct TimeRow: View {
    let title: String
    let time: TimeInterval
    
    var body: some View {
        HStack {
            Text(title).fontWeight(.semibold)
            Spacer()
            Text(DateManager.shared.string(from: time))
                .font(Font.caption.monospacedDigit())
        }
    }
}

struct TimeRow_Previews: PreviewProvider {
    static var previews: some View {
        TimeRow(title: "Block off", time: 0)
    }
}
