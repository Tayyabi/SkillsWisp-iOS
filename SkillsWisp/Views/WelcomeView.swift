//
//  WelcomeScreen.swift
//  SkillsWisp
//
//  Created by M Tayyab on 19/05/2023.
//

import SwiftUI

struct WelcomeView: View {
    
    @State private var shouldNavigate = false
    
    var body: some View {
        
        
        ZStack {
            
            Color(.white)
                .edgesIgnoringSafeArea(.top)
            
            VStack{
                
                Text("Skills Wisp")
                    .font(.custom("Pacifico-Regular", size: 34))
                    .padding(.all)
                    .foregroundColor(Color("clr_purple_mimosa"))
                
                
                Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry.")
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color.gray)
                    .font(.system(size: 14))
                    .padding(.all)
                
                NavigationLink(destination: LoginView(), label: {
                    
                    HStack {
                        
                        Image(systemName: "envelope.fill")
                            .foregroundColor(.white)
                        
                        Text("Login with Email")
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                    }
                    .padding(15)
                    .frame(width: 300)
                    .background(
                        Color("clr_purple_mimosa")
                            .cornerRadius(10)
                            .shadow(radius: 6)
                    )
                    
                })
                
                
                Spacer()
                
                Button(action: {
                    UserDefaults.standard.set(false, forKey: "is_login")
                    shouldNavigate = true
                    
                }, label: {
                    
                    Text("Sign Up Later")
                        .foregroundColor(Color("clr_purple_mimosa"))
                        .padding(.all)
                })
                
                NavigationLink(destination:HomeView(),isActive: $shouldNavigate) {
                    EmptyView()
                }
                .hidden()
                
                
            }
            .frame(minWidth: 0,
                   maxWidth: .infinity,
                   minHeight: 0,
                   maxHeight: .infinity)
            
        }
        
        .navigationBarHidden(true)
    }
}

struct WelcomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
