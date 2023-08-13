//
//  AccountSuccessView.swift
//  SkillsWisp
//
//  Created by M Tayyab on 06/08/2023.
//

import SwiftUI

struct AccountSuccessView: View {
    
    
    @State var shouldNavigate = false
    
    var body: some View {
        NavigationView {
            
            ZStack{
                Color.white
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    
                    Text("Congratulations! Your account has been Created Successfully")
                        .font(.title)
                        .fontWeight(.semibold)
                        .padding(.all)
                    
                    Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry.")
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color.gray)
                        .font(.system(size: 14))
                        .padding(.all)
                    
                    
                    Button(action:{
                        shouldNavigate.toggle()
                        
                    }, label: {
                        
                        Text("Explore Now")
                            .font(.headline)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .padding()
                            .frame(width: 260)
                            .background(
                                Color("clr_purple_mimosa")
                                    .cornerRadius(10)
                                    .shadow(radius: 6)
                                
                            )
                        
                    })
                    
                    NavigationLink(destination:HomeView(),isActive: $shouldNavigate) {
                        EmptyView()
                    }
                    .hidden()
                }
                .padding()
            }
        }
        .navigationBarHidden(true)
    }
}

struct AccountSuccessView_Previews: PreviewProvider {
    static var previews: some View {
        AccountSuccessView()
    }
}
