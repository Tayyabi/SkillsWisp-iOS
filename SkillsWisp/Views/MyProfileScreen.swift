//
//  MyProfileScreen.swift
//  SkillsWisp
//
//  Created by M Tayyab on 26/05/2023.
//

import SwiftUI

struct MyProfileScreen: View {
    
    @State var email: String = ""
    @State var password: String = ""
    
    var body: some View {
       
        VStack(alignment: .leading) {
            
            ZStack {
                
                Image("bg_matric")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 200)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    
                VStack {
                    
                    Image("ic_profile_img")
                        .resizable()
                        .frame(width: 100, height: 100)
                        .aspectRatio(contentMode: .fit)
                        .clipShape(Circle())
                    
                    Text("Alex Smith")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                    
                    Text("johnsmith@gmail.com")
                        .accentColor(.white)
                        .font(.system(size: 14))
                    
                    
                }
            }
            
            Text("Privacy Policy")
                .foregroundColor(.black)
                .fontWeight(.semibold)
                .padding(.top)
            
            HStack {
                
                Image(systemName: "phone")
                    .foregroundColor(Color.gray)
                
                TextField("Phone number", text: $email)
                    .font(.system(size: 15))
                
            }
            .padding(.top)
            
            
            Divider()
                .padding(.top)
            
            
            HStack {
                
                
                Image(systemName: "envelope")
                    .foregroundColor(Color.gray)
                
                TextField("Email", text: $email)
                    .font(.system(size: 15))
                
            }
            .padding(.top)
            
            Divider()
                .padding(.top)
            
            
            HStack {
                
                Image(systemName: "lock")
                    .foregroundColor(Color.gray)
                SecureField("Password", text: $password)
                    .font(.system(size: 15))
                
            }
            .padding(.top)
            
            
            Divider()
                .padding(.top)
            
            Spacer()
        }
        .padding()
    }
}

struct MyProfileScreen_Previews: PreviewProvider {
    static var previews: some View {
        MyProfileScreen()
    }
}
