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
    
    @State private var isEmailValid = false
    @State private var isPasswordValid = false
    
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
                        VStack(alignment: .leading) {
                            TextField("Email", text: $email)
                                .font(.system(size: 16))
                                .onChange(of: email) { newValue in
                                    isEmailValid = false
                                }
                            
                            if isEmailValid {
                                Text("Please enter email")
                                    .font(.system(size: 10))
                                    .foregroundColor(.red)
                            }
                        }
                        
                    }
                    .padding(16)
                    .background(Color("clr_light_grey").cornerRadius(10))
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(isEmailValid ? .red : Color.clear, lineWidth: 1)
                    )
                    
                    HStack{
                        
                        Image(systemName: "lock")
                            .foregroundColor(Color.gray)
                        VStack(alignment: .leading) {
                            SecureField("Password", text: $password)
                                .font(.system(size: 16))
                                .onChange(of: password) { newValue in
                                    isPasswordValid = false
                                }
                            if isPasswordValid {
                                Text("Please enter valid password")
                                    .font(.system(size: 10))
                                    .foregroundColor(.red)
                            }
                        }
                        
                        
                    }
                    .padding(16)
                    .background(Color("clr_light_grey").cornerRadius(10))
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(isPasswordValid ? .red : Color.clear, lineWidth: 1)
                    )
                    
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
                        if validation() {
                            return
                        }
                        vm.isLoading = true
                        Task {
                            //vm.authenticateUser(email: email)
                            try await vm.signIn(email: email, password: password)
                        }
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
                
                
                if vm.isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                        .scaleEffect(2)
                }
            }
        }
        .navigationBarHidden(true)
        
    }
    func validation() -> Bool {
        var chk = false
        
        if email.isEmpty {
            chk = true
            isEmailValid = true
        }
        if password.isEmpty {
            chk = true
            isPasswordValid = true
        }
        
        return chk
    }
}

struct LoginScreen_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
