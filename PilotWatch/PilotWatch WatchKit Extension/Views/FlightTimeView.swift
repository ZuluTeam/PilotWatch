//
//  FlightTimeView.swift
//  PilotWatch WatchKit Extension
//
//  Created by Konstantin Zyrianov on 2019-10-30.
//  Copyright © 2019 Zuluteam. All rights reserved.
//

import SwiftUI

struct FlightTimeView: View {
    @State private var nowDate = Date()
    
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack {
            HStack(alignment: .top) {
                Text("Block off").font(.caption)
                Spacer()
                Text("00:00:00").font(.caption)
            }
            Spacer()
        }.navigationBarTitle("UTC \(DateManager.shared.string(from: nowDate))").onReceive(timer) { _ in
            self.nowDate = Date()
        }
    }
}

struct FlightTimeView_Previews: PreviewProvider {
    static var previews: some View {
        FlightTimeView()
    }
}
