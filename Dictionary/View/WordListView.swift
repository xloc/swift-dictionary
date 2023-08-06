//
//  WordListView.swift
//  Dictionary
//
//  Created by Neil Fan on 2023-07-18.
//

import SwiftUI

struct WordListView: View {
    @EnvironmentObject var store: SavedWordsStore
    
    var body: some View {
        NavigationView{
            List{
                Section(header: Text("Notebook")){
                    NavigationLink{
                        InProgressView(wordList: store.savedWords.filter{
                            if case .reminderDate = $0.reminderPhase {return true}
                            else {return false}
                        })
                    } label: {
                        Text("In Progress")
                    }
                    NavigationLink{
                        InProgressView(wordList: store.savedWords.filter{
                            if case .learned = $0.reminderPhase {return true}
                            else {return false}
                        })
                    } label: {
                        Text("Learned")
                    }
                }
                Section(header: Text("Test")){
                    NavigationLink {
                        ExamView()
                    } label: {
                        Text("Review")
                    }
                }
                
            }
        }
        
        
    }
}

struct WordListView_Previews: PreviewProvider {
    static var previews: some View {
        WordListView()
    }
}
