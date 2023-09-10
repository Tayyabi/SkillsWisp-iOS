//
//  BookmarkScreen.swift
//  SkillsWisp
//
//  Created by M Tayyab on 26/05/2023.
//

import SwiftUI

struct BookmarkView: View {
    
    @State var thumbnails: [String] = ["bn_class_1","bn_class_2", "bn_class_3", "bn_class_4"]
    @State var selectedOption = "All"
    @State var options = ["All","Notes","Past Papers","Date Sheet"]
    
    @StateObject var vm = BookmarkViewModel()
    @State var shouldNavigate = false
    
    var body: some View {
        
        ZStack {
            Color.gray.opacity(0.1)
            
            VStack(alignment: .leading) {
                
                VStack(alignment: .leading) {
                    
                    Text("Filter by: ")
                        .font(.system(size: 14))
                        .foregroundColor(.black)
                    
                    HStack {
                        
                        ForEach(options.indices, id: \.self) {index in
                            
                            let option = options[index]
                            Button(action: {
                                
                                selectedOption = option
                                
                            }, label: {
                                Text(verbatim: "\(option)")
                                    .foregroundColor(selectedOption == option ? .white: .gray)
                                    .fontWeight(.semibold)
                                    .font(.system(size: 15))
                                    .padding(12)
                                    .background(
                                        selectedOption == option ?
                                        AnyView(
                                            
                                            RoundedRectangle(cornerRadius: 10.0)
                                                .fill(
                                                    
                                                    LinearGradient(
                                                        gradient: Gradient(
                                                            
                                                            colors: [
                                                                Color("clr_tropical_blue"),
                                                                Color("clr_purple_mimosa")
                                                            ]
                                                        ),
                                                        startPoint: .bottomLeading,
                                                        endPoint: .topTrailing
                                                    )
                                                )
                                        )
                                        :
                                        AnyView(
                                            Color("clr_light_grey").cornerRadius(10)
                                        )
                                    )
                            })
                        }
                        
                        Spacer()
                        
                    }
                }
                .padding()
                .background(Color.white)
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 10) {
                        
                        
                        ForEach(vm.notes.indices, id: \.self){ index in
                            
                            let note = vm.notes[index]
                            HStack {
                                
                                Image("\(thumbnails[index % thumbnails.count])")
                                    .renderingMode(.original)
                                    .resizable()
                                    .frame(width: 90,height: 90)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                
                                
                                VStack(alignment: .leading) {
                                    
                                    Text(note.name ?? "")
                                        .foregroundColor(.black)
                                        .fontWeight(.semibold)
                                    
                                    Text("\(note.chapter ?? "")")
                                        .foregroundColor(.gray)
                                        .font(.system(size: 13))
                                    Spacer()
                                    
                                }
                                .padding(.top, 6)
                                
                                Spacer()
                                
                                VStack(alignment: .trailing) {
                                    HStack {
                                        Image(systemName: "star.fill")
                                            .resizable()
                                            .foregroundColor(.yellow)
                                            .frame(width: 14, height: 14)
                                        
                                        Text("\(String(format: "%.1f", note.rating))")
                                            .font(.system(size: 12))
                                    }
                                    .padding(.top, 8)
                                    
                                    
                                    Spacer()
                                    
                                    Button(action: {
                                        
                                        
                                    }, label: {
                                        
                                        Image("ic_bookmark")
                                        
                                    })
                                    
                                }
                                
                                
                            }
                            .padding()
                            .background(Color.white.cornerRadius(10))
                            
                            
                        }
                        Spacer()
                        
                        
                    }
                    .padding()
                    
                }
            }
            if vm.isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                    .scaleEffect(2)
            }
        }
        
        .onAppear{
            //vm.isLoading = true
            Task {
                await vm.fetchNotes()
            }
        }
    }
}

struct BookmarkScreen_Previews: PreviewProvider {
    static var previews: some View {
        BookmarkView()
    }
}
