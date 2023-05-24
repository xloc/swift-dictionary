//
//  TextBlock.swift
//  Dictionary
//
//  Created by Oliver on 2023-05-23.
//

import SwiftUI

struct TextBlock: View {
    var text: String = ""
    var body: some View {
        ScrollView {
            Text(text)
        }.frame(maxWidth: .infinity)
    }
}

struct TextBlock_Previews: PreviewProvider {
    static var previews: some View {
        TextBlock(text: "hello")
    }
}
