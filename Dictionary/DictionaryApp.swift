//
//  DictionaryApp.swift
//  Dictionary
//
//  Created by Oliver on 2023-05-16.
//

import SwiftUI

@main
struct DictionaryApp: App {
    var body: some Scene {
        WindowGroup {
            //ContentView()
            
            //WordListView()
                
            TabView {
                ContentView()
                    .tabItem {
                        Label("Home", systemImage: "house")
                    }
                WordListView()
                    .tabItem {
                        Label("Notebook", systemImage: "book")
                    }
//                ExamView()
//                    .tabItem {
//                        Label("Notebook", systemImage: "book")
//                    }
                SettingPage()
                    .tabItem {
                        Label("Settings", systemImage: "gearshape")
                    }
            }.environmentObject(SavedWordsStore())
        }
    }
}
