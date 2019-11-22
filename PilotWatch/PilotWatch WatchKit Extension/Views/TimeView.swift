//
//  TimeView.swift
//  PilotWatch
//
//  Created by Konstantin Zyrianov on 2019-10-25.
//  Copyright © 2019 Zuluteam. All rights reserved.
//

import SwiftUI

struct TimeView: View {
    struct TimeViewState {
        var showEndurance = false
        var airborne = false
        var landed = false
    }
    
    @ObservedObject var model: TimeModel
    
    @State private var nowDate = Date()
    
    @State private var blockOffTime: TimeInterval = 0.0
    @State private var airborneTime: TimeInterval = 0.0
    
    @State private var state: TimeViewState = TimeViewState()
    
    init(model: TimeModel) {
        self.model = model
    }
    
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack(spacing: 8.0) {
            HStack(alignment: .top) {
                TimeRow(title: "Block off", time: blockOffTime)
            }
            if state.airborne {
                TimeRow(title: "Airborne", time: airborneTime)
            }
            if state.showEndurance {
                EnduranceRow(endurance: max(0, model.endurance - blockOffTime))
            }
            Spacer()
            HStack {
                if state.landed {
                    Button(action: {
                        self.model.blockOnTime = Date()
                    }, label: { Text("Block on") })
                } else if state.airborne {
                    Button(action: {
                        self.model.landingTime = Date()
                        self.state.airborne = false
                        self.state.landed = true
                    }, label: { Text("Land") })
                } else {
                    Button(action: {
                        self.model.takeOffTime = Date()
                        self.state.airborne = true
                    }, label: { Text("Take off") })
                }
            }
        }.onAppear(perform: { self.state.showEndurance = self.model.endurance > 0 }).navigationBarTitle("UTC \(DateManager.shared.string(from: nowDate))").onReceive(timer) { _ in
            self.nowDate = Date()
            self.blockOffTime = (self.model.blockOnTime ??  self.nowDate).timeIntervalSince(self.model.blockOffTime)
            if let takeOffTime = self.model.takeOffTime {
                self.airborneTime = (self.model.landingTime ?? self.nowDate).timeIntervalSince(takeOffTime)
                self.state.airborne = true
            }
        }
    }
}

struct TimeView_Previews: PreviewProvider {
    static var previews: some View {
        TimeView(model: TimeModel(blockOffTime: Date(), endurance: 100.0))
    }
}
