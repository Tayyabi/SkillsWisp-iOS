//
//  HomeScreen.swift
//  SkillsWisp
//
//  Created by M Tayyab on 20/05/2023.
//

import SwiftUI

struct HomeScreen: View {
    
    @State var notes: String = ""
    
    let columns: [GridItem] = [
        
        GridItem(.flexible(), spacing: 6, alignment: nil),
        GridItem(.flexible(), spacing: 6, alignment: nil),
    ]
    
    var body: some View {
        
        NavigationView {
            
            ScrollView(showsIndicators: false) {
                
                ZStack {
                    
                    Color.white
                        .edgesIgnoringSafeArea(.all)
                    
                    VStack(alignment: .leading) {
                        Text("Find your favorite Notes on the go")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .padding(.top)
                        
                        
                        HStack {
                            
                            TextField("Search notes", text: $notes)
                                .font(.system(size: 16))
                            
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.black)
                            
                        }
                        .padding(12)
                        .overlay(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(lineWidth: 1).foregroundColor(Color.gray)
                        )
                        
                        
                        
                        Text("Explore by Standard")
                            .fontWeight(.semibold)
                        
                        
                        ScrollView(.horizontal, showsIndicators: false)
                        {
                           
                            HStack {
                                
                                NavigationLink(destination: MatricScreen(), label: {
                                    VStack {
                                        
                                        Image("ic_matric")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 100, height: 100)
                                        Text("Matriculation")
                                            .foregroundColor(.black)
                                            .font(.system(size: 14))
                                    }
                                    .padding()
                                    .background(
                                        Color("clr_aqua_squeeze")
                                            .cornerRadius(10)
                                    )
                                    
                                })
                                
                                
                                VStack {
                                    
                                    Image("ic_inter")
                                        .resizable()
                                    .aspectRatio( contentMode: .fit)
                                    .frame(width: 100, height: 100)
                                    Text("Intermediate")
                                        .font(.system(size: 14))
                                }
                                .padding()
                                .background(
                                    Color("clr_yellow_green")
                                        .cornerRadius(10)
                                )
                                
                                
                                
                                VStack {
                                    
                                    Image("ic_bachelors")
                                        .resizable()
                                        .aspectRatio( contentMode: .fit)
                                        .frame(width: 100, height: 100)
                    
                                    Text("Bachelors")
                                        .font(.system(size: 14))
                                }
                                .padding()
                                .background(
                                    Color("clr_tropical_blue")
                                        .cornerRadius(10)
                                )
                            }
                        }
                        .frame(height: 150)
                        
                        Text("Explore more options")
                            .fontWeight(.semibold)
                            .padding(.top)
                        
                        LazyVGrid(
                            columns: columns,
                            spacing: 10,
                            pinnedViews: [],
                            content: {
                                HStack {
                                    
                                    
                                    Image("ic_past_paper")
                                        .resizable()
                                        .frame(width: 20, height: 20)
                                        .padding(10)
                                        .background(Color("blue").cornerRadius(radius: 6, corners: .allCorners))
                                        .shadow(radius: 0)
                                    
                                    
                                    Text("Past Papers")
                                        .font(.system(size: 14))
                                    
                                }
                                .frame(width: 140)
                                .padding()
                                .background(Color.white.cornerRadius(radius: 6, corners: .allCorners))
                                .shadow(radius: 2)
                            
                                HStack {
                                    
                                    
                                    Image("ic_guess_paper")
                                        .resizable()
                                        .frame(width: 20, height: 20)
                                        .padding(10)
                                        .background(Color("clr_v_light_purple")
                                            .cornerRadius(radius: 6, corners: .allCorners))
                                        .shadow(radius: 0)
                                    
                                    
                                    Text("Guess Papers")
                                        .font(.system(size: 14))
                                    
                                }
                                .frame(width: 140)
                                .padding()
                                .background(Color.white.cornerRadius(radius: 6, corners: .allCorners))
                                .shadow(radius: 2)
                                
                                
                                
                                
                                
                                HStack {
                                    
                                    
                                    Image("ic_date_sheet")
                                        .resizable()
                                        .frame(width: 20, height: 20)
                                        .padding(10)
                                        .background(Color("clr_light_orange")
                                            .cornerRadius(radius: 6, corners: .allCorners))
                                        .shadow(radius: 0)
                                    
                                    
                                    Text("Date Sheet")
                                        .font(.system(size: 14))
                                    
                                }
                                .frame(width: 140)
                                .padding()
                                .background(Color.white.cornerRadius(radius: 6, corners: .allCorners))
                                .shadow(radius: 2)
                                
                                
                                HStack {
                                    
                                    
                                    Image("ic_bookmark")
                                        .resizable()
                                        .frame(width: 20, height: 20)
                                        .padding(10)
                                        .background(Color("clr_pale_pink")
                                            .cornerRadius(radius: 6, corners: .allCorners))
                                        .shadow(radius: 0)
                                    
                                    
                                    Text("Bookmarked")
                                        .font(.system(size: 14))
                                    
                                }
                                .frame(width: 140)
                                .padding()
                                .background(Color.white.cornerRadius(radius: 6, corners: .allCorners))
                                .shadow(radius: 2)
                                
                            })
                        
                        HStack {
                            
                            Image("ic_ai")
                                .resizable()
                                .frame(width: 110, height: 120)
                            
                            VStack(alignment: .leading) {
                                Text("Ask AI")
                                    
                                    .fontWeight(.semibold)
                                    .padding(0)
                            
                                Text("Ask the questions related to your study from Artificial Intelligence Model"
                                    )
                                .padding(0)
                                .font(.system(size: 14))
                                .foregroundColor(Color("clr_dark_grey"))
                                .multilineTextAlignment(.leading)
                                .fixedSize(horizontal: false, vertical: true)
                                .frame(height: 40)
                                
                                
                                Button(action: {
                                    
                                }, label: {
                                    Text("Get in")
                                        .foregroundColor(Color.orange)
                                        .padding(12)
                                        .padding([.leading, .trailing])
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 15)
                                                .stroke(lineWidth: 1).foregroundColor(Color.orange)
                                        )
                                })
                                .padding(.top, 10)
                                
                            }
                            
                            
                        }
                        .frame(
                              minWidth: 0,
                              maxWidth: .infinity,
                              minHeight: 0,
                              maxHeight: .infinity,
                              alignment: .topLeading
                            )
                        .padding()
                        .background(Color("clr_light_orange").cornerRadius(radius: 6, corners: .allCorners))
                        .shadow(radius: 2)
                        
                        
                        Spacer()
                    }
                    .padding([.leading, .trailing])
                    
                    
                    
                }
            }
            
            .navigationBarItems(
                leading: NavigationLink(destination: SettingsScreen(),label: {
                    
                    Image("ic_menu")
                        .resizable()
                        .frame(width: 30, height: 30)
                    
                }),
                trailing: NavigationLink(destination: MyProfileScreen(),label: {
                    
                    Image("ic_profile")
                        .resizable()
                        .clipShape(Circle())
                        .frame(width: 35, height: 35)
                        .shadow(radius: 10)
                    
                })
            )
        }
        
        .navigationBarHidden(true)
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}
