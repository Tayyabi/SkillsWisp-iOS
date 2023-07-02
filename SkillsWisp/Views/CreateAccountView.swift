//
//  CreateAccountScreen.swift
//  SkillsWisp
//
//  Created by M Tayyab on 20/05/2023.
//

import SwiftUI

struct CheckboxToggleStyle: ToggleStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        HStack {
 
            RoundedRectangle(cornerRadius: 5.0)
                .stroke(lineWidth: 3)
                .frame(width: 20, height: 20)
                .cornerRadius(5.0)
//                .overlay {
//                    Image(systemName: configuration.isOn ? "checkmark" : "")
//                }
                .onTapGesture {
                    withAnimation(.spring()) {
                        configuration.isOn.toggle()
                    }
                }
 
            configuration.label
 
        }
    }
}

struct CreateAccountView: View {
    
    @State var name: String = ""
    @State var email: String = ""
    @State var phoneno: String = ""
    @State var password: String = ""
    
    @State private var isChecked = false
    @StateObject var vm = CreateAccountViewModel()
    
    var body: some View {
        
        NavigationView {
            
            ZStack{
                
                Color.white
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    
                    Text("Create an account")
                        .font(.title)
                        .fontWeight(.semibold)
                        .padding(.all)
                    
                    Image("ic_profile_img")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 120, height: 120)
                        .clipShape(Circle())
                        .shadow(radius: 10)
                        .overlay(Circle().stroke(Color.yellow, lineWidth: 1))
                        .padding()
                    
                    
                    
                    HStack{
                        Image(systemName: "person")
                            .foregroundColor(Color.gray)
                        TextField("Full Name", text: $name)
                            .font(.system(size: 15))
                        
                    }
                    .padding(14)
                    .background(Color("clr_light_grey").cornerRadius(radius: 10, corners: .allCorners))
                    
                    
                    HStack {
                        Image(systemName: "envelope")
                            .foregroundColor(Color.gray)
                        TextField("Email", text: $email)
                            .font(.system(size: 15))
                        
                    }
                    .padding(14)
                    .background(Color("clr_light_grey").cornerRadius(radius: 10, corners: .allCorners))
                    
                    
                    
                    HStack {
                        
                        Image(systemName: "phone")
                            .foregroundColor(Color.gray)
                        TextField("Phone Number", text: $phoneno)
                            .font(.system(size: 15))
                        
                    }
                    .padding(14)
                    .background(Color("clr_light_grey").cornerRadius(radius: 10, corners: .allCorners))
                    
                    HStack {
                        
                        Image(systemName: "lock")
                            .foregroundColor(Color.gray)
                        SecureField("Password", text: $password)
                            .font(.system(size: 15))
                        
                    }
                    .padding(14)
                    .background(Color("clr_light_grey").cornerRadius(radius: 10, corners: .allCorners))
                    
                    HStack {
                        
                        Toggle(isOn: $isChecked) {
                            
                            Text("Accept term and condition for using SkillsWisp")
                                .font(.system(size: 14))
                                .padding(.leading, 5)
                                .foregroundColor(Color.gray)
                            
                        }
                        .toggleStyle(CheckboxToggleStyle())
                        
                        Spacer()
                    }
                    
                    
                    Spacer()
                    
                    Button(action:{
                        
                        guard !name.isEmpty && !email.isEmpty && !phoneno.isEmpty else {
                            return
                        }
                        
                        vm.addUser(user: User(user_id: UUID(), full_name: name, email: email, phone_no: phoneno, pic_url: ""))
                        
                    }, label: {
                        
                        Text("Register")
                            .font(.headline)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .padding(15)
                            .frame(width: 300)
                            .background(
                                Color("clr_purple_mimosa")
                                    .cornerRadius(10)
                                    .shadow(radius: 6)
                                
                            )
                        
                    })
                    
                    
                    HStack{
                        
                        Text("Already have an account?")
                            .font(.system(size: 16))
                        
                        Button(action:{
                            
                        }, label: {
                            Text("SIGN IN")
                                .foregroundColor(Color("clr_purple_mimosa"))
                            
                        })
                        
                    }
                    .padding()
                    
                }
                .padding()
                
            }
            
        }
    }
}

struct CreateAccountScreen_Previews: PreviewProvider {
    static var previews: some View {
        CreateAccountView()
    }
}
