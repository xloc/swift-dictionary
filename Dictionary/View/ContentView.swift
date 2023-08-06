//
//  ContentView.swift
//  Dictionary
//
//  Created by Oliver on 2023-05-16.
//

import SwiftUI
import ChatGPTSwift


let API_KEY = "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"
var api = ChatGPTAPI(apiKey: API_KEY)

struct ContentView: View {
    
    @EnvironmentObject var store: SavedWordsStore
    
    @AppStorage("apiKey") private var apiKey = ""
    
    
    @State var searchedText: String = ""
    @State var captureText: String = ""
    
    @State var definition: String = ""
    @State var detailedDefinition: String = ""
    @State var examples: String = ""
    @State var translation: String = ""
    @State var loading = false
    @FocusState private var wordIsFocused: Bool
    
    var favorited: Bool {
        if captureText == "" {
            return false
        }
        return store.savedWords.contains(where: {$0.word == captureText})
    }
    
    init() {
        api = ChatGPTAPI(apiKey: apiKey)
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
        
        wordIsFocused = false
        
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
                    .focused($wordIsFocused)
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
                        
                        var word = SavedWord(
                            word: captureText,
                            definition: definition,
                            detailedDefinition: detailedDefinition,
                            examples: examples,
                            translation: translation)
                        store.savedWords.append(word)
                        word.changeReminderDate(testResult: .forgot)
                    } label: {
                        Image(systemName: favorited ? "star.fill" : "star")
                    } .disabled(loading)
                }
                Divider()
            }
            ScrollView{
                VStack (alignment: .leading) {
                    if !definition.isEmpty {Text("Definition").bold()}
                    Text(definition).padding(.bottom, 3)
                    if !detailedDefinition.isEmpty {Text("Detailed Definition").bold()}
                    Text(detailedDefinition).padding(.bottom, 3)
                    if !examples.isEmpty {Text("Examples").bold()}
                    Text(examples).padding(.bottom, 3)
                    if !translation.isEmpty {Text("Translation").bold()}
                    HidableTextBlock(text: translation)
                }.padding(.horizontal, 5)
            }
            
        }
        .padding()
        .onAppear(){
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                if success {
                    // print("All set!")
                } else if let error = error {
                    print(error.localizedDescription)
                }
            }
        }
        .onChange(of: apiKey) { _ in
            api = ChatGPTAPI(apiKey: apiKey)
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
