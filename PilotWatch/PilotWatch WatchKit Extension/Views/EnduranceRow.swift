//
//  EnduranceRow.swift
//  PilotWatch WatchKit Extension
//
//  Created by Konstantin Zyrianov on 2019-11-08.
//  Copyright © 2019 Zuluteam. All rights reserved.
//

import SwiftUI

struct EnduranceRow: View {
    let endurance: TimeInterval
    
    @State private var pulsate = false
    
    func fontWeight() -> Font.Weight {
        return (endurance <= DateManager.criticalEndurance) ? .black : (endurance <= DateManager.dangerousEndurance) ? .bold : .regular
    }
    
    func textColor() -> Color {
        return (endurance <= DateManager.criticalEndurance) ? Color.red : (endurance <= DateManager.dangerousEndurance) ? Color.yellow : Color.white
    }
    
    var body: some View {
        HStack {
            Text("Endurance").fontWeight(.semibold)
            Spacer()
            Text(DateManager.shared.string(from: endurance))
                .font(Font.caption.monospacedDigit())
                .fontWeight(fontWeight())
                .foregroundColor(textColor())
                .opacity(pulsate ? 0 : 1)
                .animation(Animation.linear(duration: 1).repeatForever(autoreverses: true))
                .onAppear() {
                    if self.endurance <= DateManager.criticalEndurance {
                        self.pulsate.toggle()
                    }
            }
        }
    }
}

struct Endurance_Previews: PreviewProvider {
    static var previews: some View {
        EnduranceRow(endurance: 0)
    }
}
