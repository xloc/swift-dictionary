//
//  SettingPage.swift
//  Dictionary
//
//  Created by Oliver on 2023-05-23.
//

import SwiftUI

var selectedIntervalIndex = 0



struct SettingPage: View {
    @AppStorage("apiKey") private var apiKey = ""
    @EnvironmentObject var store: SavedWordsStore
    
    @State var memoryStages: [TimeInterval] = SavedWord.memoryStages
    @State var isShowSheet = false
    
    func formatTimeInterval(interval: TimeInterval) -> String {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .full
        formatter.allowedUnits = [.weekOfMonth, .day, .hour]
        
        return formatter.string(from: interval) ?? "Error"
    }
    
    var body: some View {
        Form {
            Section(header: Text("API Key")) {
                TextField("API Key", text: $apiKey)
            }
            
            Section(header: Text("Review Schedule")) {
                List {
                    ForEach(memoryStages.indices, id: \.self) { index in
                        Button {
                            selectedIntervalIndex = index
                            isShowSheet = true
                        } label: {
                            Text(formatTimeInterval(interval: memoryStages[index]))
                        }
                    }
                    Button {
                        memoryStages = [5*60*60, 24*60*60, 3*24*60*60, 7*24*60*60, 30*24*60*60]
                    } label: {
                        Text("Restore to default")
                            .foregroundColor(.red)
                    }
                }

            }
        }
        .navigationBarTitle("Settings")
        .sheet(isPresented: $isShowSheet) {
            IntervalPicker(interval: $memoryStages[selectedIntervalIndex])
                .presentationDetents([.fraction(0.4)])
        }
        .onAppear {
            memoryStages = SavedWord.memoryStages
        }
        .onChange(of: memoryStages) { newValue in
            SavedWord.memoryStages = newValue
            print("save setting to memory \(newValue)")
            print(SavedWord.memoryStages)
        }
        
    }
}

struct SettingPage_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SettingPage()
        }
    }
}
