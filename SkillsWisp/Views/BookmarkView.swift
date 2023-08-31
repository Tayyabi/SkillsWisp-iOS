//
//  BookmarkScreen.swift
//  SkillsWisp
//
//  Created by M Tayyab on 26/05/2023.
//

import SwiftUI

struct BookmarkView: View {
    
    @State var thumbnails: [String] = ["bn_class_1","bn_class_2", "bn_class_3", "bn_class_4"]
    
    @StateObject var vm = BookmarkViewModel()
    @State var shouldNavigate = false
    
    var body: some View {
        
        ZStack {
            ScrollView(showsIndicators: false) {
                VStack {
                    
                    
                    ForEach(vm.notes.indices, id: \.self){ index in
                        
                        let note = vm.notes[index]
                        HStack {
                            
                            Image("\(thumbnails[index % thumbnails.count])")
                                .renderingMode(.original)
                                .resizable()
                                .frame(width: 90,height: 90)
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                            
                            
                            VStack(alignment: .leading) {
                                
                                Text(note.name ?? "")
                                    .foregroundColor(.black)
                                    .fontWeight(.semibold)
                                    .font(.title3)
                                
                                Text("\(note.chapter ?? "")")
                                    .foregroundColor(.gray)
                                Spacer()
                                
                            }
                            .padding(.top, 8)
                            
                            Spacer()
                            
                            VStack(alignment: .trailing) {
                                HStack {
                                    Image(systemName: "star.fill")
                                        .foregroundColor(.yellow)
                                    
                                    Text("\(String(format: "%.1f", note.rating))")
                                        .font(.system(size: 14))
                                }
                                .padding(.top, 8)
                                
                                
                                Spacer()
                                
                                Button(action: {
                                    
                                    
                                }, label: {
                                    
                                    Image("ic_bookmark")
                                    
                                })
                                
                            }
                            
                            
                        }
                        .frame(height: 100)
                        .padding()
                        .background(Color.white.cornerRadius(20))
                        .padding([.top, .leading, .trailing], 10)
                        
                        
                    }
                    Spacer()
                    
                    
                }
                .background(Color.gray.opacity(0.1))
            }
            if vm.isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                    .scaleEffect(2)
            }
        }
        
        .onAppear{
            vm.isLoading = true
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
