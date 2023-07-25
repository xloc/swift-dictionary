//
//  DictionaryApp.swift
//  Dictionary
//
//  Created by Oliver on 2023-05-16.
//

import SwiftUI

@main
struct DictionaryApp: App {
    @StateObject var store = SavedWordsStore()
    @Environment(\.scenePhase) var appState
    
    var body: some Scene {
        
        WindowGroup {
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
            }.environmentObject(store)
            .task {
                do {
                    try await store.load()
                } catch {
                    print("error on load")
                }
            }
            .onChange(of: appState) { phase in
                if case .inactive = phase {
                    Task {
                        do {
                            try await store.save()
                            print("data saved")
                        } catch {
                            print("Error on save")
                        }
                    }
                }
            }
        }
    }
}
