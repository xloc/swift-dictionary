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
    @State var detailedDefinition: String = ""
    @State var examples: String = ""
    @State var translation: String = ""
    
    
    func onSearch () {
        captureText = searchedText
        searchedText = ""
        
        definition = ""
        detailedDefinition = ""
        examples = ""
        translation = ""
        
        api.deleteHistoryList()

        
        
        
        Task {
            do {
                let definitionPrompt = """
                define '\(captureText)' with a one-sentence concise definition
                """
                definition = try await api.sendMessage(
                    text: definitionPrompt,
                    model: "gpt-3.5-turbo",
                    systemText: "you are dictionaryGPT"
                )
                
                let detailedDefinitionPrompt = """
                add 1-3 sentenses of explanation
                """
                detailedDefinition = try await api.sendMessage(
                    text: detailedDefinitionPrompt,
                    model: "gpt-3.5-turbo"
                )
                
                let examplePrompt = """
                give me 2 example sentences using the word
                """
                examples = try await api.sendMessage(
                    text: examplePrompt,
                    model: "gpt-3.5-turbo"
                )
                
                let translationPrompt = """
                give a 1 sentence definition in Chinese
                """
                translation = try await api.sendMessage(
                    text: translationPrompt,
                    model: "gpt-3.5-turbo"
                )
                
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
            
            Text(captureText).font(.title)
            
            ScrollView {
                if (captureText.count > 0) { Divider() }
                if (definition.count > 0) {Text(definition)}
                if (detailedDefinition.count > 0) {
                    Divider()
                    Text(detailedDefinition)
                }
                if (examples.count > 0) {
                    Divider()
                    Text(examples)
                }
                if (translation.count > 0) {
                    Divider()
                    Text(translation)
                }
            }

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
