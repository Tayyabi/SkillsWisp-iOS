//
//  SettingsScreen.swift
//  SkillsWisp
//
//  Created by M Tayyab on 24/05/2023.
//

import SwiftUI

struct SettingsScreen: View {
    var body: some View {
        
        //NavigationView {
            ZStack {
                
                VStack{
                    
                    ZStack {
                        Image("bg_maths")
                            .resizable()
                            .frame(height: 130)
                        
                        HStack {
                            Image("ic_setting_profile")
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 80, height: 80)
                                .clipShape(Circle())
                            
                            VStack(alignment: .leading) {
                                
                                Text("John Smith")
                                    .foregroundColor(.white)
                                    .fontWeight(.semibold)
                                    .font(.title2)
                                
                                Text("johnsmith@gmail.com")
                                    .accentColor(.white)
                                    .font(.system(size: 14))
                                
                            }
                            
                            Spacer()
                            
                            NavigationLink(destination: {
                                MyProfileScreen()
                            }, label: {
                                Image("ic_right_arrow")
                            })
                            
                        }
                        .padding(20)
                    }
                    
                    
                    NavigationLink(destination: BookmarkScreen(), label: {
                        HStack {
                            Text("Bookmarked Notes")
                                .foregroundColor(Color.black)
                            Spacer()
                            Image("ic_right_arrow")
                                .renderingMode(.template)
                                .accentColor(.black)
                                .foregroundColor(.black)
                        }
                        .padding(20)
                        .background(Color.gray.opacity(0.2).cornerRadius(10))
                        .padding(.top)
                    })
                    
                    
                    
                    HStack {
                        Text("Invite Friends")
                            .foregroundColor(Color.black)
                        Spacer()
                        Image("ic_right_arrow")
                            .renderingMode(.template)
                            .accentColor(.black)
                            .foregroundColor(.black)
                    }
                    .padding(20)
                    .background(Color.gray.opacity(0.2).cornerRadius(10))
                    
                    HStack {
                        Text("Push Notifications")
                            .foregroundColor(Color.black)
                        Spacer()
                        
                    }
                    .padding(20)
                    .background(Color.gray.opacity(0.2).cornerRadius(10))
                    
                    NavigationLink(destination: ContactUsScreen(), label: {
                        HStack {
                            Text("Contact Us")
                                .foregroundColor(Color.black)
                            Spacer()
                            Image("ic_right_arrow")
                                .renderingMode(.template)
                                .accentColor(.black)
                                .foregroundColor(.black)
                        }
                        .padding(20)
                        .background(Color.gray.opacity(0.2).cornerRadius(10))
                    })
                    
                    
                    NavigationLink(destination: AboutUsScreen(), label: {
                    HStack {
                        Text("About Us")
                            .foregroundColor(Color.black)
                        Spacer()
                        Image("ic_right_arrow")
                            .renderingMode(.template)
                            .accentColor(.black)
                            .foregroundColor(.black)
                    }
                    .padding(20)
                    .background(Color.gray.opacity(0.2).cornerRadius(10))
                    })
                    
                    NavigationLink(destination: TermsConditionScreen(), label: {
                        HStack {
                            Text("Privacy Policy")
                                .foregroundColor(Color.black)
                            Spacer()
                            Image("ic_right_arrow")
                                .renderingMode(.template)
                                .accentColor(.black)
                                .foregroundColor(.black)
                        }
                        .padding(20)
                        .background(Color.gray.opacity(0.2).cornerRadius(10))
                    })
                    
                    Spacer()
                    
                    
                    NavigationLink(destination: {
                        LoginScreen()
                        
                    }, label: {
                        Text("Log out")
                            .foregroundColor(.red)
                    })
                    
                }
                .padding()
                
            }
//        }
//        .navigationBarHidden(false)
    }
}

struct SettingsScreen_Previews: PreviewProvider {
    static var previews: some View {
        SettingsScreen()
    }
}
