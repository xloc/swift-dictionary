//
//  IntervalPicker.swift
//  Dictionary
//
//  Created by Oliver on 2023-07-20.
//

import SwiftUI

struct IntervalPicker: View {
    @Binding var interval: TimeInterval
    
    @State var weeks: Int = 0
    @State var days: Int = 0
    @State var hours: Int = 0

    init(interval: Binding<TimeInterval>) {
        self._interval = interval
        print("interval \(interval.wrappedValue)")
    }
    
    func updateInterval(_: Int) {
        interval = Double(weeks * 7*24*60*60 + days * 24*60*60 + hours * 60*60)
    }
    
    var body: some View {
        HStack {
            Picker(selection: $weeks, label: Text("Weeks")) {
                ForEach(0...12, id: \.self) { index in
                    Text(index.formatted() + " w")
                }
            }
            .pickerStyle(.wheel)
            .onChange(of: weeks, perform: updateInterval)
            
            Picker(selection: $days, label: Text("Days")) {
                ForEach(0...7, id: \.self) { index in
                    Text(index.formatted() + " d")
                }
            }
            .pickerStyle(.wheel)
            .onChange(of: days, perform: updateInterval)
            
            Picker(selection: $hours, label: Text("Hours")) {
                ForEach(0..<24, id: \.self) { index in
                    Text(index.formatted() + " hr")
                }
            }
            .pickerStyle(.wheel)
            .onChange(of: hours, perform: updateInterval)
        }.onAppear {
            var intInterval = Int(interval)
            self.weeks = intInterval / (7*24*60*60)
            intInterval %= (7*24*60*60)
            self.days = intInterval / (24*60*60)
            intInterval %= (24*60*60)
            self.hours = intInterval / (60*60)
        }
    }
}

struct IntervalPicker_Previews: PreviewProvider {
    static var previews: some View {
        IntervalPicker(interval: Binding.constant(3600))
    }
}
