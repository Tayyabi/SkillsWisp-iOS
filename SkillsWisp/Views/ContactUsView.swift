//
//  ContactUsScreen.swift
//  SkillsWisp
//
//  Created by M Tayyab on 26/05/2023.
//

import SwiftUI

struct ContactUsView: View {
    
    @State var email: String = ""
    @State var message: String = "Message"
    
    var body: some View {
        
        
        VStack(alignment: .center, spacing: 6) {
            
            
            Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry.")
                .foregroundColor(.gray)
                .font(.system(size: 14))
                .multilineTextAlignment(.center)
                .padding(.top, 40)
            
            
            
            HStack{
                TextField("Email", text: $email)
                    .font(.system(size: 15))
                
            }
            .padding()
            .background(Color("clr_light_grey").cornerRadius(radius: 10, corners: .allCorners))
            .padding(.top, 40)
            
            
            HStack{
                
                TextEditor(text: $message)
                    .font(.system(size: 15))
                    .frame(height: 160)
                    .padding(14)
                    .colorMultiply(Color("clr_light_grey"))
                
            }
            .background(Color("clr_light_grey").cornerRadius(radius: 10, corners: .allCorners))
            .padding(.top)
            
            
            Button(action:{
                
            }, label: {
                Text("Send Now")
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .padding(16)
                    .frame(width: 250)
                    .background(
                        Color("clr_purple_mimosa")
                            .cornerRadius(10)
                            .shadow(radius: 6)
                        
                    )
                
            })
            .padding(.top, 40)
            
            Spacer()
        }
        .padding()
        
        
    }
}

struct ContactUsScreen_Previews: PreviewProvider {
    static var previews: some View {
        ContactUsView()
    }
}
