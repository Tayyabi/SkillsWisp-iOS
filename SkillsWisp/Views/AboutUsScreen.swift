//
//  AboutUsScreen.swift
//  SkillsWisp
//
//  Created by M Tayyab on 26/05/2023.
//

import SwiftUI

struct AboutUsScreen: View {
    var body: some View {
        
        ScrollView{
            VStack(alignment: .leading, spacing: 6) {
                
                Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum. Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. ")
                    .foregroundColor(.gray)
                    .font(.system(size: 14))
                
                Spacer()
                
            }
            .padding()
        }
    }
            
            
}

struct AboutUsScreen_Previews: PreviewProvider {
    static var previews: some View {
        AboutUsScreen()
    }
}
