//
//  SubjectScreen.swift
//  SkillsWisp
//
//  Created by M Tayyab on 23/05/2023.
//

import SwiftUI

struct SubjectView: View {
    
    
    var gridItems: [GridItem] = [
        GridItem(.flexible(), spacing: 0, alignment: .leading),
        GridItem(.flexible(), spacing: 0, alignment: .leading)
    ]
    
    @State var classes: [Notes] = [
        Notes(name: "9th Class Physics", background: "bn_class_1"),
        Notes(name: "9th Class Physics", background: "bn_class_2"),
        Notes(name: "9th Class Physics", background: "bn_class_3"),
        Notes(name: "9th Class Physics", background: "bn_class_4"),
        Notes(name: "9th Class Physics", background: "bn_class_1"),
        Notes(name: "9th Class Physics", background: "bn_class_2"),
        Notes(name: "9th Class Physics", background: "bn_class_3"),
        Notes(name: "9th Class Physics", background: "bn_class_4")
    ]
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        
        
        
        ZStack {
            
            
            VStack(spacing: nil) {
                
                
                ZStack{
                    
                    Image("bg_matric")
                        .aspectRatio(contentMode: .fit)
                    
                    
                    HStack {
                        
                        VStack(alignment: .leading, spacing: 6) {
                            
                            Button(action: {
                                presentationMode.wrappedValue.dismiss()
                            }, label: {
                                Image("ic_left_arrow")
                                    .padding(.bottom)
                            })
                            
                            Text("Physics")
                                .foregroundColor(.white)
                                .fontWeight(.semibold)
                                .font(.title2)
                            
                            Text("Get solved notes by top professors of Pakistan")
                                .foregroundColor(.white)
                                .font(.system(size: 14))
                            
                            
                        }
                        
                        Image("ic_subj")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 200, height: 200)
                        
                        
                    }
                    .frame(
                        minWidth: 0,
                        maxWidth: .infinity
                    )
                    
                }
                
                
                ScrollView(showsIndicators: false) {
                    
                    LazyVGrid(columns: gridItems) {
                        
                        ForEach(classes) { classs in
                            
                            NavigationLink(destination: NotesView(), label: {
                                
                                
                                VStack(alignment: .leading) {
                                    
                                    
                                    Image("\(classs.background)")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(height: 180)
                                        .clipShape(RoundedRectangle(cornerRadius: 15))
                                    
                                    HStack {
                                        Text("\(classs.name)")
                                            .font(.system(size: 16))
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            .foregroundColor(.black)
                                        
                                        Spacer()
                                        Image(systemName: "star.fill")
                                            .foregroundColor(.yellow)
                                        
                                        Text("4.9")
                                            .foregroundColor(.black)
                                            .font(.system(size: 14))
                                        
                                    }
                                    .frame(
                                        maxWidth: .infinity
                                    )
                                    
                                    Text("All Chapters")
                                        .font(.system(size: 14))
                                        .foregroundColor(.gray)
                                    
                                    
                                }
                                .padding(4)
                                
                                
                            })
                            
                        }
                        
                    }
                }
                
            }
            
        }.edgesIgnoringSafeArea([.leading,.trailing,.top])
        
            .navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)
    }
}

struct SubjectScreen_Previews: PreviewProvider {
    static var previews: some View {
        SubjectView()
    }
}
