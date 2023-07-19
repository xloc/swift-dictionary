//
//  WordListView.swift
//  Dictionary
//
//  Created by Robert Xiao on 2023-07-18.
//

import SwiftUI

struct WordListView: View {
    @EnvironmentObject var store: SavedWordsStore
    var body: some View {
        NavigationView{
            List{
                NavigationLink{
                    List(store.savedWords.filter{if case .reminderDate = $0.reminderPhase {return true}
                        else {return false}}) { word in
                            NavigationLink{
                                DetailsView(word: word)
                            } label: {
                                Text(word.word)
                            }
                    }
                } label: {
                    Text("In Progress")
                }
                NavigationLink{
                    List(store.savedWords.filter{if case .learned = $0.reminderPhase {return true}
                        else {return false}}) { word in
                            NavigationLink{
                                DetailsView(word: word)
                            } label: {
                                Text(word.word)
                            }
                    }
                } label: {
                    Text("Learned")
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
