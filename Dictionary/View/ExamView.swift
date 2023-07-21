//
//  ExamView.swift
//  Dictionary
//
//  Created by Oliver on 2023-07-17.
//

import SwiftUI

struct ExamView: View {
    @EnvironmentObject var store: SavedWordsStore
    
//    var wordsToReview: [SavedWord] {
//        store.savedWords.filter {word in
//            if case let .reminderDate(date) = word.reminderPhase {
//                return date < Date()
//            } else {
//                return false
//            }
//        }.first!
//    }
    
//    @State lazy var wordToReview: SavedWord = {
//        store.savedWords.first { word in
//           if case let .reminderDate(date) = word.reminderPhase {
//               return date < Date()
//           } else {
//               return false
//           }
//       }
//    }()
    
    func reviewWordsPredicate(_ word: SavedWord) -> Bool {
        switch word.reminderPhase {
        case .reminderDate(let date):
            return date < Date()
        case .learned:
            return false
        }
    }
    
    var body: some View {
        let wordBindingOptional = $store.savedWords.first {
            reviewWordsPredicate($0.wrappedValue)
        }
        if let wordBinding = wordBindingOptional {
            Text(store.savedWords.filter(reviewWordsPredicate).count.formatted())
            ExamQuestionView(word: wordBinding)
        } else {
            Text("No word to review")
        }
    }
}

struct ExamView_Previews: PreviewProvider {
    static var previews: some View {
        ExamView()
    }
}
