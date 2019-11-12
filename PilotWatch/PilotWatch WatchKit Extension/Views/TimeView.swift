//
//  TimeView.swift
//  PilotWatch
//
//  Created by Konstantin Zyrianov on 2019-10-25.
//  Copyright © 2019 Zuluteam. All rights reserved.
//

import SwiftUI

struct TimeView: View {
    @ObservedObject var model: TimeModel
    
    @State private var nowDate = Date()
    
    @State private var blockOffTime: TimeInterval = 0.0
    @State private var airborneTime: TimeInterval = 0.0
    
    @State private var showEndurance: Bool = false
    @State private var showAirborne: Bool = false
    
    init(model: TimeModel) {
        self.model = model
    }
    
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack(spacing: 8.0) {
            HStack(alignment: .top) {
                TimeRow(title: "Block off", time: blockOffTime)
            }
            if showAirborne {
                TimeRow(title: "Airborne", time: airborneTime)
            }
            if showEndurance {
                EnduranceRow(endurance: max(0, model.endurance - blockOffTime))
            }
            Spacer()
            Button(action: {
                self.model.takeOffTime = Date()
            }, label: { Text("Take off") })
        }.onAppear(perform: { self.showEndurance = self.model.endurance > 0 }).navigationBarTitle("UTC \(DateManager.shared.string(from: nowDate))").onReceive(timer) { _ in
            self.nowDate = Date()
            self.blockOffTime = self.nowDate.timeIntervalSince(self.model.blockOffTime)
            if let takeOffTime = self.model.takeOffTime {
                self.airborneTime = self.nowDate.timeIntervalSince(takeOffTime)
                self.showAirborne = true
            }
        }
    }
}

struct TimeView_Previews: PreviewProvider {
    static var previews: some View {
        TimeView(model: TimeModel(blockOffTime: Date(), endurance: 10.0))
    }
}
