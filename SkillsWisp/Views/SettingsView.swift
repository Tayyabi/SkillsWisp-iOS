//
//  SettingsScreen.swift
//  SkillsWisp
//
//  Created by M Tayyab on 24/05/2023.
//

import SwiftUI

struct SettingsView: View {
    
    @State private var logout = false
    
    
    var body: some View {
        
        ZStack {
            
            VStack{
                
                ZStack {
                    Image("bg_setting")
                        .resizable()
                        .frame(height: 130)
                    
                    HStack {
                        let picture_url = UserDefaults.standard.string(forKey: "picture_url") ?? ""
                        RemoteImage(url: URL(string: picture_url)!)
                            .clipShape(Circle())
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 80, height: 80)
                            .clipShape(Circle())
                        
                        VStack(alignment: .leading) {
                            
                            Text("\(UserDefaults.standard.string(forKey: "full_name") ?? "UnKnown")")
                                .foregroundColor(.white)
                                .fontWeight(.semibold)
                                .font(.title3)
                            
                            Text("\(UserDefaults.standard.string(forKey: "email") ?? "UnKnown")")
                                .accentColor(.white)
                                .font(.system(size: 14))
                                .foregroundColor(.white)
                            
                        }
                        
                        Spacer()
                        
                        NavigationLink(destination: {
                            ProfileView()
                        }, label: {
                            Image("ic_right_arrow")
                        })
                        
                    }
                    .padding(20)
                }
                
                
                /*NavigationLink(destination: BookmarkView(), label: {
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
                })*/
                
                
                HStack {
                    Text("Invite Friends")
                        .font(.system(size: 15))
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
                
                HStack {
                    Text("Push Notifications")
                        .font(.system(size: 15))
                        .foregroundColor(Color.black)
                    Spacer()
                    
                }
                .padding(20)
                .background(Color.gray.opacity(0.2).cornerRadius(10))
                
                NavigationLink(destination: ContactUsView(), label: {
                    HStack {
                        Text("Contact Us")
                            .font(.system(size: 15))
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
                
                
                NavigationLink(destination: AboutUsView(), label: {
                    HStack {
                        Text("About Us")
                            .font(.system(size: 15))
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
                
                NavigationLink(destination: TermsConditionView(), label: {
                    HStack {
                        Text("Privacy Policy")
                            .font(.system(size: 15))
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
                
                
                Button(action: {
                    logout = true
                }, label: {
                    Text("Log out")
                        .foregroundColor(.red)
                })
                
            }
            .padding()
            
        }
        .fullScreenCover(isPresented: $logout, content: {
            LoginView()
        })
        
    }
}

struct SettingsScreen_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
