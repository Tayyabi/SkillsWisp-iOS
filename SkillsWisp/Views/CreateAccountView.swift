//
//  CreateAccountScreen.swift
//  SkillsWisp
//
//  Created by M Tayyab on 20/05/2023.
//

import SwiftUI
import Firebase
import FirebaseStorage

struct CheckboxToggleStyle: ToggleStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        HStack {
 
            RoundedRectangle(cornerRadius: 5.0)
                .stroke(lineWidth: 3)
                .frame(width: 20, height: 20)
                .cornerRadius(5.0)
                .overlay(
                    Image(systemName: configuration.isOn ? "checkmark" : "")
                )
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
    
    @State private var selectedImage: UIImage?
    @State private var isShowingImagePicker = false
    
    @State var name: String = ""
    @State var email: String = ""
    @State var phoneno: String = ""
    @State var password: String = ""
    
    @State private var isNameValid = false
    @State private var isEmailValid = false
    @State private var isPhoneValid = false
    @State private var isPasswordValid = false
    
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
                    
                    if let image = selectedImage {
                        Image(uiImage: image)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 140, height: 140)
                            .clipShape(Circle())
                            .shadow(radius: 10)
                            .overlay(Circle().stroke(Color.yellow, lineWidth: 1))
                            .padding()
                            .onTapGesture {
                                isShowingImagePicker = true
                            }
                    }
                    else {
                        
                        Image("ic_profile_img")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 140, height: 140)
                            .clipShape(Circle())
                            .shadow(radius: 10)
                            .overlay(Circle().stroke(Color.yellow, lineWidth: 1))
                            .padding()
                            .onTapGesture {
                                isShowingImagePicker = true
                            }
                    }
                    
                    
                    Group {
                        
                        HStack{
                            Image(systemName: "person")
                                .foregroundColor(Color.gray)
                            VStack(alignment: .leading) {
                                TextField("Full Name", text: $name)
                                    .font(.system(size: 15))
                                    .onChange(of: name) { newValue in
                                        isNameValid = false
                                    }
                                
                                if isNameValid {
                                    Text("Please enter fullname")
                                        .font(.system(size: 10))
                                        .foregroundColor(.red)
                                }
                            }
                                
                            
                        }
                        .padding(14)
                        .background(Color("clr_light_grey"))
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(isNameValid ? .red : Color.clear, lineWidth: 1)
                        )
                        
                        
                        
                        HStack {
                            Image(systemName: "envelope")
                                .foregroundColor(Color.gray)
                            VStack(alignment: .leading) {
                                TextField("Email", text: $email)
                                    .font(.system(size: 15))
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
                        .padding(14)
                        .background(Color("clr_light_grey").cornerRadius(10))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(isEmailValid ? .red : Color.clear, lineWidth: 1)
                        )
                        
                        
                        HStack {
                            
                            Image(systemName: "phone")
                                .foregroundColor(Color.gray)
                            VStack(alignment: .leading) {
                                TextField("Phone Number", text: $phoneno)
                                    .font(.system(size: 15))
                                    .onChange(of: phoneno) { newValue in
                                        isPhoneValid = false
                                    }
                                if isPhoneValid {
                                    Text("Please enter phone")
                                        .font(.system(size: 10))
                                        .foregroundColor(.red)
                                }
                            }
                            
                        }
                        .padding(14)
                        .background(Color("clr_light_grey").cornerRadius(10))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(isPhoneValid ? .red : Color.clear, lineWidth: 1)
                        )
                        
                        HStack {
                            
                            Image(systemName: "lock")
                                .foregroundColor(Color.gray)
                            VStack(alignment: .leading) {
                                SecureField("Password", text: $password)
                                    .font(.system(size: 15))
                                    .onChange(of: password) { newValue in
                                        isPasswordValid = false
                                    }
                                if isPasswordValid {
                                    Text("Please enter phone")
                                        .font(.system(size: 10))
                                        .foregroundColor(.red)
                                }
                            }
                            
                        }
                        .padding(14)
                        .background(Color("clr_light_grey").cornerRadius(10))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(isPasswordValid ? .red : Color.clear, lineWidth: 1)
                        )
                        
                    }
                    
                    Group {
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
                            
                        
                            if validation() {
                                return
                            }
                            
                            vm.isLoading = true
                            Task {
                                try? await vm.createUser(fullName: name, email: email, password: password, phoneNo: phoneno, picUrl: "")
                                
                                name = ""
                                email = ""
                                password = ""
                                phoneno = ""
                            }
                            
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
                    
                }
                .padding()
                
                if vm.isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                        .scaleEffect(2)
                }
                
                if vm.isSuccessfull {
                    AccountSuccessView()
                }
                
            }
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
    
    func validation() -> Bool {
        var chk = false
        if name.isEmpty {
            chk = true
            isNameValid = true
        }
        if email.isEmpty {
            chk = true
            isEmailValid = true
        }
        if phoneno.isEmpty {
            chk = true
            isPhoneValid = true
        }
        if password.isEmpty {
            chk = true
            isPasswordValid = true
        }
        
        return chk
    }
}

struct CreateAccountScreen_Previews: PreviewProvider {
    static var previews: some View {
        CreateAccountView()
    }
}
