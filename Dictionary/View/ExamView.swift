//
//  ExamView.swift
//  Dictionary
//
//  Created by Oliver on 2023-07-17.
//

import SwiftUI

struct ExamView: View {
    @Binding var word: SavedWord
    
    var body: some View {
        VStack {
            Spacer()
            Text(word.word).font(.title)
            Spacer()

            NavigationLink {
                DetailsView(word: word)
            } label: {
                Text("Details").foregroundColor(.blue)
            }
            HStack {
                Spacer()
                Button {
                    word.changeReminderDate(testResult: .remember)
                } label: {
                    Text("Remember")
                }
                Spacer()
                Button {
                    word.changeReminderDate(testResult: .forgot)
                } label: {
                    Text("Forgot")
                }
                Spacer()
            }.padding(.vertical, 20)
        }
    }
}

struct ExamView_Previews: PreviewProvider {
    static let word = SavedWord(
        word: "Hello",
        definition: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
        detailedDefinition: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
        examples: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
        translation: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.")
    
    
    static var previews: some View {
        NavigationStack {
            ExamView(word: Binding.constant(word))
        }
    }
}
