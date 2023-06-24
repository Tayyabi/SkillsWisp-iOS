//
//  ReviewPopup.swift
//  SkillsWisp
//
//  Created by M Tayyab on 21/06/2023.
//

import SwiftUI

struct ReviewPopup: View {
    
    @State var selected: Int = -1
    
    var body: some View {
        
        ZStack {
            
            Color.black.opacity(0.2).edgesIgnoringSafeArea(.all)
            
            VStack {
                Image("ic_review")
                    .resizable()
                    .frame(width: 150,height: 150)
                    .aspectRatio(contentMode: .fill)
                Text("Please rate the note")
                    .fontWeight(.bold)
                
                HStack(spacing: 10){
                    ForEach(0..<5){ i in
                        
                        Image(systemName: "star.fill").resizable()
                            .frame(width: 22, height: 22)
                            .foregroundColor(self.selected >= i ? .yellow : .gray)
                            .onTapGesture {
                                self.selected = i
                            }
                    }
                }
                .padding()
                
                Button(action: {
                    
                }, label: {
                    
                    Text("Confirm")
                        .frame(width: 160, height: 30)
                        .foregroundColor(.white)
                        .padding(10)
                        .background(Color("clr_purple_mimosa").cornerRadius(10))
                        
                        
                })

                
            }
            .frame(width: 280)
            .padding(20)
            .background(Color.white.cornerRadius(20))
            
        }
    }
}

struct ReviewPopup_Previews: PreviewProvider {
    static var previews: some View {
        ReviewPopup()
    }
}
