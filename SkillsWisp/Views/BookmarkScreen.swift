//
//  BookmarkScreen.swift
//  SkillsWisp
//
//  Created by M Tayyab on 26/05/2023.
//

import SwiftUI

struct BookmarkScreen: View {
    var body: some View {
    
        NavigationView {
            ScrollView(showsIndicators: false) {
                VStack {
                    
                    
                    ForEach(1..<10){ index in
                        
                        HStack {
                            
                            Image("bn_maths")
                                .renderingMode(.original)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 90,height: 90)
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                                .overlay(RoundedRectangle(cornerRadius: 20))
                            
                            
                            VStack(alignment: .leading) {
                                
                                Text("9th Class Physics")
                                    .foregroundColor(.black)
                                    .fontWeight(.semibold)
                                    .font(.title3)
                                
                                Text("All Chapters")
                                    .foregroundColor(.gray)
                                Spacer()
                                
                            }
                            .padding(.top, 8)
                            
                            Spacer()
                            
                            VStack(alignment: .trailing) {
                                HStack {
                                    Image(systemName: "star.fill")
                                        .foregroundColor(.yellow)
                                    
                                    Text("4.9")
                                        .font(.system(size: 14))
                                }
                                .padding(.top, 8)
                                
                                
                                Spacer()
                                
                                Button(action: {
                                    
                                    
                                }, label: {
                                    
                                    Image("ic_bookmark")
                                    
                                })
                                
                            }
                            
                            
                        }
                        .frame(height: 100)
                        .padding()
                        .background(Color.white.cornerRadius(20))
                        .padding([.top, .leading, .trailing], 10)
                        
                        
                    }
                    Spacer()
                    
                    
                }
                .background(Color.gray.opacity(0.1))
            }
        }
        .navigationBarHidden(false)
    }
}

struct BookmarkScreen_Previews: PreviewProvider {
    static var previews: some View {
        BookmarkScreen()
    }
}
