//
//  TextBootcamp.swift
//  SkillsWisp
//
//  Created by M Tayyab on 09/05/2023.
//

import SwiftUI

struct TextBootcamp: View {
    var body: some View {
        Text("Hello, world! ug ugiu j iuh ig iuh libn ijh kjh ljkh kjhkjh  kgkuv")
//            .font(.body)
//            .fontWeight(.heavy)
//            .bold()
//            .underline()
//            .underline(true,color: Color.red)
//            .italic()
//            .strikethrough(true, color: Color.green)
            //.font(.system(size: 24, weight: .semibold, design: .serif))
            //.baselineOffset(50.0)
            //.kerning(2)
            .foregroundColor(.red)
            .multilineTextAlignment(.leading)
            //.frame(width: 200, height: 80, alignment: .leading)
            .minimumScaleFactor(10)
        
    }
}

struct TextBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        TextBootcamp()
    }
}
