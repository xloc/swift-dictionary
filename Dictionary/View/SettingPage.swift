//
//  SettingPage.swift
//  Dictionary
//
//  Created by Oliver on 2023-05-23.
//

import SwiftUI

//var selectedIntervalIndex = 0

struct SettingPage: View {
    @AppStorage("apiKey") private var apiKey = ""
    @EnvironmentObject var store: SavedWordsStore
    
    @State var memoryStages: [TimeInterval] = SavedWord.memoryStages
    @State var isShowSheet = false
    @State var selectedIntervalIndex: Int = 0
    
//    mutating func updateIndex(index: Int) {
//        selectedIntervalIndex = index
//    }
    
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
                            print(selectedIntervalIndex.formatted()  + CACurrentMediaTime().formatted())
                            isShowSheet = true
//                            self.updateIndex(index)
                        } label: {
                            Text(memoryStages[index].formatted())
                        }
                    }
                }
            }
        }
//        .navigationBarTitle("Settings")
        .sheet(isPresented: $isShowSheet) {
//
////                Text(selectedIntervalIndex.formatted())
            Text(selectedIntervalIndex.formatted() + CACurrentMediaTime().formatted())
//    //            if let index = selectedIntervalIndex {
                    IntervalPicker(interval: $memoryStages[selectedIntervalIndex])
//    //            }
//
         

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
