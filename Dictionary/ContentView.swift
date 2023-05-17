//
//  ContentView.swift
//  Dictionary
//
//  Created by Oliver on 2023-05-16.
//

import SwiftUI
import ChatGPTSwift


let API_KEY = "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"
let api = ChatGPTAPI(apiKey: API_KEY)

struct ContentView: View {
    @State var searchedText: String = ""
    @State var captureText: String = ""
    @State var definition: String = ""
    
    
    func onSearch () {
        captureText = searchedText
        searchedText = ""
        definition = ""
        
        api.deleteHistoryList()
        let prompt = "\(captureText) meaning in 3-5 sentences"
        Task {
            do {
                definition = try await api.sendMessage(text: prompt)
                // is there any other error handling ways?
            } catch  {
                definition = error.localizedDescription
            }
        }
    }
    
    var body: some View {
        VStack {
            HStack {
                TextField("Search a word here",text: $searchedText)
                    .keyboardShortcut(.defaultAction)
                    .onSubmit(onSearch)
                Button(action: onSearch) {
                    Image(systemName: "magnifyingglass.circle")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(.accentColor)
                }
            }
            
            Text(captureText)
            Text(definition)

            Spacer()
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
