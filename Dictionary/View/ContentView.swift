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
    @Environment(\.scenePhase) var appState
    @EnvironmentObject var store: SavedWordsStore
    
    @State var searchedText: String = ""
    @State var captureText: String = ""
    
    @State var definition: String = ""
    @State var detailedDefinition: String = ""
    @State var examples: String = ""
    @State var translation: String = ""
    @State var loading = false
    
    var favorited: Bool {
        if captureText == "" {
            return false
        }
        return store.savedWords.contains(where: {$0.word == captureText})
    }
    
    func onSearch () {
        loading = true

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
                
                loading = false
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
            

            if (captureText.count > 0) {
                HStack {
                    Text(captureText).font(.title)
                    Spacer()
                    Button {
                        if favorited {
                            store.savedWords.removeAll(where: {$0.word == captureText})
                            return
                        }
                        
                        let word = SavedWord(
                            word: captureText,
                            definition: definition,
                            detailedDefintion: detailedDefinition,
                            examples: examples,
                            translation: translation)
                        store.savedWords.append(word)
                    } label: {
                        Image(systemName: favorited ? "star.fill" : "star")
                    } .disabled(loading)
                }
                Divider()
            }
            
            GeometryReader { metrics in
                VStack(spacing: 0) {
                    TextBlock(text: definition + "\n\n" + detailedDefinition)
                        .frame(height: metrics.size.height * 0.5)
                    Divider()
                    TextBlock(text: examples)
                        .frame(height: metrics.size.height * 0.4)
                    Divider()
                    HidableTextBlock(text: translation)
                        .frame(height: metrics.size.height * 0.1)
                }
            }
        }
        .padding()
        .onChange(of: appState) { _ in
            if case .inactive = appState {
                Task {
                    do {
                        try await store.save()
                    } catch {
                        print("Error on save")
                    }
                }
            }
        }
        .task {
            do {
                try await store.load()
            } catch {
                print("error on load")
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
