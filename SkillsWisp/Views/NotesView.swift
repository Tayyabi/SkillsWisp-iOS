//
//  NotesScreen.swift
//  SkillsWisp
//
//  Created by M Tayyab on 11/06/2023.
//

import SwiftUI

struct NotesView: View {
    
    
    @State var showView: Bool = false
    
    var body: some View {
        
        
        ZStack(alignment: .bottom) {
            
            VStack {
                
                ZStack(alignment: .bottomTrailing) {
                    
                    Color.gray.opacity(0.1)
                    
                    
                    VStack{
                        
                        Button(action: {}, label: {
                            
                            Image(systemName: "hand.thumbsup")
                                .foregroundColor(.black)
                                .padding()
                                .background(Circle().foregroundColor(.white))
                        })
                        Text("1.5k")
                        
                        Button(action: {
                            
                            showView.toggle()
                            
                        }, label: {
                            
                            Image(systemName: "message")
                                .foregroundColor(.black)
                                .padding()
                                .background(Circle().foregroundColor(.white))
                        })
                        .popover(isPresented: $showView) {
                            ReviewsView()
                        }
                        Text("1.5k")
                        
                    }
                    .padding()
                    
                }
                
                HStack {
                    Spacer()
                    Button(action: {}, label: {
                        
                        Image(systemName: "square.and.arrow.down")
                            .foregroundColor(.black)
                            .padding()
                            .background(Circle().foregroundColor(.white))
                    })
                    
                    Spacer()
                    
                    Button(action: {}, label: {
                        
                        Image(systemName: "bookmark")
                            .foregroundColor(.black)
                            .padding()
                            .background(Circle().foregroundColor(.white))
                    })
                    
                    Spacer()
                    
                    Button(action: {}, label: {
                        
                        Image(systemName: "arrowshape.turn.up.forward")
                            .foregroundColor(.black)
                            .padding()
                            .background(Circle().foregroundColor(.white))
                    })
                    Spacer()
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.gray.opacity(0.1))
            }
            
            
        }
        .navigationTitle("Notes")
        .navigationBarTitleDisplayMode(.inline)
        
    }
}

struct NotesScreen_Previews: PreviewProvider {
    static var previews: some View {
        NotesView()
    }
}
