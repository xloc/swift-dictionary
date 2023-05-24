//
//  HidableTextBlock.swift
//  Dictionary
//
//  Created by Oliver on 2023-05-23.
//

import SwiftUI

struct HidableTextBlock: View {
    @State private var hidden = true
    
    var text: String;
    
    var body: some View {
        ScrollView {
            Text(text)
                .blur(radius: hidden ? 5 : 0)
                
                .contentShape(Rectangle())
                .onTapGesture {
                    hidden = !hidden
                }
        }.frame(maxWidth: .infinity)
    }
}

struct HidableTextBlock_Previews: PreviewProvider {
    static var previews: some View {
        
        HidableTextBlock(text: "aposijfdpaio aospdijfpa aisdjfpoai aisdjpfoia aiopsdjfpo apsoidfjpa paosidfjpo ")
    
    }
}
