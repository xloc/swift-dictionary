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
                            Text(memoryStages[index].formatted())
                        }
                    }
                }
            }
        }
        .navigationBarTitle("Settings")
        .sheet(isPresented: $isShowSheet) {
            IntervalPicker(interval: $memoryStages[selectedIntervalIndex])
        }
        .onAppear {
            memoryStages = SavedWord.memoryStages
        }
        .onChange(of: memoryStages) { newValue in
            SavedWord.memoryStages = newValue
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
