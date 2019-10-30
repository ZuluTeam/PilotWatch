//
//  TimeView.swift
//  PilotWatch
//
//  Created by Konstantin Zyrianov on 2019-10-25.
//  Copyright © 2019 Zuluteam. All rights reserved.
//

import SwiftUI

struct TimeView: View {
    private let durationFormatter: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .positional
        return formatter
    }()
    
    @ObservedObject var model: TimeModel
    
    @State private var nowDate = Date()
    
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack {
            HStack(alignment: .top) {
                Text("Endurance").font(.caption)
                Spacer()
                Text("00:00:00").font(.caption)
            }
            Spacer()
        }.navigationBarTitle("UTC \(DateManager.shared.string(from: nowDate))").onReceive(timer) { _ in
            self.nowDate = Date()
        }
    }
}

struct TimeView_Previews: PreviewProvider {
    static var previews: some View {
        TimeView(model: TimeModel(blockOffTime: Date()))
    }
}
