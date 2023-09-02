//
//  MyProfileScreen.swift
//  SkillsWisp
//
//  Created by M Tayyab on 26/05/2023.
//

import SwiftUI

struct ProfileView: View {
    
    @State var phoneno: String = ""
    @State var email: String = ""
    @State var password: String = ""
    @State var isEditable: Bool = false
    
    @State private var selectedImage: UIImage?
    @State private var isShowingImagePicker = false
    
    @StateObject var vm = ProfileViewModel()
    
    var body: some View {
        
        VStack(alignment: .leading) {
            
            ZStack {
                
                Image("bg_profile")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 200)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                
                VStack {
                    
                    
                    Group {
                        if let image = selectedImage {
                            
                            Image(uiImage: image)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .clipShape(Circle())
                                
                        }
                        else {
                            
                            if(vm.userModel?.picUrl != nil) {
                                RemoteImage(url: URL(string: vm.userModel?.picUrl ?? "")!)
                                    
                            }
                        }
                    }
                    .frame(width: 110, height: 110)
                    .onTapGesture {
                        isShowingImagePicker = true
                    }
                    
                    
                    Text(vm.userModel?.fullName ?? "Unknown")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                    
                    Text(vm.userModel?.email ?? "Unknown")
                        .accentColor(.white)
                        .font(.system(size: 14))
                        .foregroundColor(.white)
                    
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
                    get: { vm.userModel?.phoneNo ?? "" },
                    set: { vm.userModel?.phoneNo = $0 }
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
                    get: { vm.userModel?.email ?? "" },
                    set: { vm.userModel?.email = $0 }
                ))
                .font(.system(size: 15))
                .disabled(true)
                
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
                        
                        guard let name = vm.userModel?.fullName,
                              let phone = vm.userModel?.phoneNo else {
                            return
                        }
                        Task {
                            await vm.updateUser(fullName: name, phoneNo: phone)
                        }
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
        .onAppear{
            vm.getCache()
        }
        
        
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
        
        .sheet(isPresented: $isShowingImagePicker, onDismiss: {
            
            guard let image = selectedImage,
                  let imageData = image.jpegData(compressionQuality: 0.5) else {
                print("Failed to get image data.")
                return
                
            }
            vm.imageData = imageData
        }) {
            ImagePicker(selectedImage: $selectedImage)
            
        }
    }
}

struct MyProfileScreen_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
