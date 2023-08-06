//
//  InProgressView.swift
//  Dictionary
//
//  Created by Neil Fan on 2023-07-24.
//

import SwiftUI

struct InProgressView: View {
    @EnvironmentObject var store: SavedWordsStore
    var wordList: [SavedWord]
    
    var body: some View {
        List{
            ForEach(wordList) { word in
                NavigationLink{
                    DetailsView(word: word)
                } label: {
                    HStack{
                        Text(word.word)
                        Spacer()
                        Text(word.reminderPhaseDescription)
                    }
                    
                }
            }.onDelete { idx in
                for i in idx{
                    let word2del = wordList[i]
                    store.savedWords.removeAll(where: {$0.word == word2del.word})
                }
                
            }
        }
    }
}

//struct InProgressView_Previews: PreviewProvider {
//    static var previews: some View {
//        InProgressView()
//    }
//}
