//
//  LoginScreen.swift
//  SkillsWisp
//
//  Created by M Tayyab on 20/05/2023.
//

import SwiftUI

struct LoginView: View {
    
    @State var email: String = "muhammadtayyab703@gmail.com"
    @State var password: String = ""
    
    
    @StateObject var vm = LoginViewModel()
    
    var body: some View {
        
        NavigationView {
            
            ZStack {
                
                Color.white
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    
                    
                    GifImage("login_gif")
                        .frame(width: 160, height: 160)
                    
                    
                    Text("Login to your account")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .padding(.all)
                    
                    HStack{
                        
                        Image(systemName: "envelope")
                            .foregroundColor(Color.gray)
                        
                        TextField("Email", text: $email)
                            .font(.system(size: 15))
                        
                    }
                    .padding(14)
                    .background(Color("clr_light_grey").cornerRadius(radius: 10, corners: .allCorners))
                    
                    HStack{
                        
                        Image(systemName: "lock")
                            .foregroundColor(Color.gray)
                        SecureField("Password", text: $password)
                            .font(.system(size: 15))
                        
                        
                    }
                    .padding(14)
                    .background(Color("clr_light_grey").cornerRadius(radius: 10, corners: .allCorners))
                    
                    HStack{
                        Button(action: {
                            
                            
                        }, label: {
                            
                            Text("Forget Password?")
                                .foregroundColor(Color("clr_purple_mimosa"))
                                .font(.system(size: 14))
                                .padding(.leading, 5)
                            
                            
                        })
                        Spacer()
                    }
                    
                    
                    Spacer()
                    
                    Button(action: {
                        guard !email.isEmpty else {
                            return
                        }
                        guard !password.isEmpty else {
                            return
                        }
                        vm.authenticateUser(email: email)
                    }, label: {
                        Text("Login")
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
                    
                    NavigationLink(destination:HomeView(),isActive: $vm.shouldNavigate) {
                        EmptyView()
                    }
                    .hidden()
                    
                    
                    
                    HStack{
                        
                        Text("Don't have account?")
                            .font(.system(size: 16))
                        
                        NavigationLink(destination: CreateAccountView(), label: {
                            Text("SIGN UP")
                                .foregroundColor(Color("clr_purple_mimosa"))
                        })
                        
                    }
                    .padding()
                    
                }
                .padding()
                
            }
        }
        .navigationBarHidden(true)
        
    }
}

struct LoginScreen_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
