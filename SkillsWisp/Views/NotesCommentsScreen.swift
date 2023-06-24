//
//  NotesCommentsScreen.swift
//  SkillsWisp
//
//  Created by M Tayyab on 26/05/2023.
//

import SwiftUI

struct NotesCommentsScreen: View {
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack {
                
                
                ForEach(1..<10) { index in
                    
                    
                    VStack {
                        HStack {
                            
                            Image("bn_maths")
                                .renderingMode(.original)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 75,height: 75)
                                .clipShape(Circle())
                                .overlay(Circle())
                            
                            
                            VStack(alignment: .leading, spacing: 5) {
                                
                                HStack(alignment: .center) {
                                    
                                    Text("John Smith")
                                        .foregroundColor(.black)
                                        .fontWeight(.semibold)
                                    
                                    Spacer()
                                    
                                    Image(systemName: "star.fill")
                                        .foregroundColor(.yellow)
                                    
                                    Text("4.9")
                                        .font(.system(size: 14))
                                    
                                    
                                }
                                
                                Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry.")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 15))
                            }
                            
                            
                            
                        }
                        .frame(height: 75)
                        .padding()
                     
                        
                        Divider()
                            .padding([.leading, .trailing], 15)
                    }
                    
                }
                Spacer()
                
                
            }
        }
    }
}

struct NotesCommentsScreen_Previews: PreviewProvider {
    static var previews: some View {
        NotesCommentsScreen()
    }
}
