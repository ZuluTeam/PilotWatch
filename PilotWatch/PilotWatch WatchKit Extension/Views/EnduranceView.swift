//
//  EnduranceView.swift
//  PilotWatch WatchKit Extension
//
//  Created by Konstantin Zyrianov on 2019-07-31.
//  Copyright © 2019 Zuluteam. All rights reserved.
//

import SwiftUI

struct EnduranceView : View {
    weak var host: EnduranceController?
    
    @State private var nowDate = Date()
    
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    @State private var hourEndurance = 1
    @State private var minuteEndurance = 0
    @State private var tanksReminderTime = 30
    
    private static let maxHourEndurance: Int = 50
    private static let maxMinuteEndurance: Int = 60
    private static let minutesStep: Int = 15
    private static let maxReminderTime: Int = 60
    private static let reminderStep: Int = 5
    
    var body: some View {
        VStack {
            Form {
                Section {
                    VStack {
                        Text("Flight endurance").font(.caption)
                        HStack {
                            Spacer()
                            Picker(selection: $hourEndurance, label: Text("Hours")) {
                                ForEach(0...EnduranceView.maxHourEndurance) {
                                    Text(String(format: "%02d", $0))
                                }
                            }.onAppear(perform: {
                                self.hourEndurance = Int(UserDefaults.standard.double(forKey: UserDefaultsKeys.lastEndurance) / 3600)
                            }).layoutPriority(1)
                            Picker(selection: $minuteEndurance, label: Text("Minutes")) {
                                ForEach(stride(from: 0, to: EnduranceView.maxMinuteEndurance, by: EnduranceView.minutesStep).map({ $0 })) {
                                    Text(String(format: "%02d", $0))
                                }
                            }.onAppear(perform: {
                                self.minuteEndurance = Int(UserDefaults.standard.double(forKey: UserDefaultsKeys.lastEndurance) / 60) % 60
                            }).layoutPriority(1)
                            Spacer()
                        }.frame(width: nil, height: 80, alignment: .center)
                    }.padding()
                }
                Section {
                    VStack {
                        HStack {
                            Text("Set reminder to switch tanks").font(.caption)
                            Picker(selection: $tanksReminderTime, label: Text("Minutes")) {
                                ForEach(stride(from: EnduranceView.reminderStep, to: EnduranceView.maxReminderTime, by: EnduranceView.reminderStep).map({ $0 })) {
                                    Text(String(format: "%02d", $0))
                                }
                            }.fixedSize(horizontal: true, vertical: false)
                        }.frame(width: nil, height: 80, alignment: .center)
                    }.padding()
                }
                Section {
                    Button(action: {
                        let endurance = TimeInterval((self.hourEndurance * 60 + self.minuteEndurance) * 60)
                        self.host?.startTime(withBlockOffTime: Date(), endurance: endurance)
                    }, label: { Text("Block off") }).padding()
                }
            }
            
        }.navigationBarTitle("UTC \(DateManager.shared.string(from: nowDate))").onReceive(timer) { _ in
            self.nowDate = Date()
        }
    }
}

#if DEBUG
struct EnduranceView_Previews : PreviewProvider {
    static var previews: some View {
        EnduranceView()
    }
}
#endif
