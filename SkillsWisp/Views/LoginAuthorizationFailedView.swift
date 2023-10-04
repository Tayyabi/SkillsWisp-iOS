//
//  LoginAuthorizationFailedView.swift
//  SkillsWisp
//
//  Created by M Tayyab on 03/10/2023.
//

import SwiftUI

struct LoginAuthorizationFailedView: View {
    
    @Binding var confirm: Bool
    
    var body: some View {
        ZStack {
            
            Color.black.opacity(0.3).edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 0) {
                
                Image("ic_authentication_fail")
                    .resizable()
                    .frame(width: 120,height: 120)
                    .aspectRatio(contentMode: .fill)
                
                Text("Wrong Login Details")
                    .font(.system(size: 18))
                    .fontWeight(.bold)
                    .padding(.top, 5)
                
                Text("You have entered wrong email or password, Please try again with correct credidentials")
                    .multilineTextAlignment(.center)
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
                    .padding()
                
                
                Button(action: {
                    confirm.toggle()
                }, label: {
                    
                    Text("Try Again")
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding(15)
                        .frame(width: 160, height: 42)
                        .background(
                            Color("clr_purple_mimosa")
                                .cornerRadius(10)
                                .shadow(radius: 6)
                            )
                        .padding(.bottom)
                        
                })

                
            }
            .padding()
            .background(Color.white.cornerRadius(20))
            .padding(30)
            
        }
    }
}

struct LoginAuthorizationFailedView_Previews: PreviewProvider {
    @State static var confirm: Bool = false
    static var previews: some View {
        LoginAuthorizationFailedView(confirm: $confirm)
    }
}
