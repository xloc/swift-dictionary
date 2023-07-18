//
//  DetailsView.swift
//  Dictionary
//
//  Created by Oliver on 2023-07-17.
//

import SwiftUI

struct DetailsView: View {
    var word: SavedWord

    
    var body: some View {
        VStack {
            Text(word.word).font(.title)
            VStack (alignment: .leading) {
                Text("Definition").bold()
                Text(word.definition).padding(.bottom, 3)
                Text("Detailed Definition").bold()
                Text(word.detailedDefintion).padding(.bottom, 3)
                Text("Examples").bold()
                Text(word.examples).padding(.bottom, 3)
                Text("Translation").bold()
                Text(word.translation)
            }.padding(.horizontal, 5)
        }
        .frame(
            maxWidth: .infinity,
            maxHeight: .infinity,
            alignment: .topLeading
        )
    }
}

struct DetailsView_Previews: PreviewProvider {
    static let word = SavedWord(
        word: "Hello",
        definition: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
        detailedDefintion: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
        examples: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
        translation: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.")
    
    static var previews: some View {
        DetailsView(word: word)
    }
}
