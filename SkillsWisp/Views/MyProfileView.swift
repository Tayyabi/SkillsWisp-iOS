//
//  MyProfileScreen.swift
//  SkillsWisp
//
//  Created by M Tayyab on 26/05/2023.
//

import SwiftUI

struct MyProfileView: View {
    
    @State var phoneno: String = ""
    @State var email: String = ""
    @State var password: String = ""
    @State var isEditable: Bool = false
    
    @StateObject var vm = MyProfileViewModel()
    
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
                    
                    Text(vm.userDetails?.full_name ?? "Unknown")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                    
                    Text(vm.userDetails?.email ?? "Unknown")
                        .accentColor(.white)
                        .font(.system(size: 14))
                    
                }
            }
            
            Text("Profile Details")
                .foregroundColor(.black)
                .fontWeight(.semibold)
                .padding(.top)
            
            HStack {
                
                Image(systemName: "phone")
                    .foregroundColor(Color.gray)
                
                TextField("Phone number", text: Binding(
                    get: { vm.userDetails?.phone_no ?? "" },
                    set: { vm.userDetails?.phone_no = $0 }
                ))
                .font(.system(size: 15))
                .disabled(!isEditable)
                
            }
            .padding(.top)
            
            
            Divider()
                .padding(.top)
            
            
            HStack {
                
                Image(systemName: "envelope")
                    .foregroundColor(Color.gray)
                
                TextField("Email", text: Binding(
                    get: { vm.userDetails?.email ?? "" },
                    set: { vm.userDetails?.email = $0 }
                ))
                .font(.system(size: 15))
                .disabled(!isEditable)
                
            }
            .padding(.top)
            
            Divider()
                .padding(.top)
            
            
            
            Button(action: {
                
            }, label: {
                
                HStack {
                    
                    Image(systemName: "lock")
                        .foregroundColor(Color.gray)
                    
                    Text("Change Password")
                        .font(.system(size: 15))
                        .foregroundColor(Color.gray)
                    
                }.padding(.top)
                
            })
            
            
            
            
            Spacer()
            
            if isEditable {
                VStack {
                    Button(action: {
                        self.isEditable.toggle()
                    }, label: {
                        Text("Confirm")
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
                }
                .frame(maxWidth: .infinity)
            }
            
        }
        .padding()
        
        
        .navigationBarTitle("My Profile")
        .navigationBarItems(trailing: Button(action: {
            self.isEditable.toggle()
        }) {
            Image(systemName: "pencil")
                .frame(width: 35, height: 35)
                .padding(5)
                .foregroundColor(.black)
                .background(Circle().foregroundColor(.gray).opacity(0.2))
            
        })
    }
}

struct MyProfileScreen_Previews: PreviewProvider {
    static var previews: some View {
        MyProfileView()
    }
}
