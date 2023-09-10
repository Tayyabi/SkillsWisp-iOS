//
//  DownloadedNotesView.swift
//  SkillsWisp
//
//  Created by M Tayyab on 05/09/2023.
//

import SwiftUI

struct DownloadedNotesView: View {
    
    @State var thumbnails: [String] = ["bn_class_1","bn_class_2", "bn_class_3", "bn_class_4"]
    @State var selectedOption = "All"
    @State var options = ["All","Notes","Past Papers","Date Sheet"]
    
    @StateObject var vm = DownloadsViewModel()
    @State var shouldNavigate = false
    
    var body: some View {
        
        
        
        ZStack {
            
            Color.gray.opacity(0.1)
            
            VStack {
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
                                
                                Image("ic_downloaded_thumb")
                                    .renderingMode(.original)
                                    .resizable()
                                    .frame(width: 90,height: 110)
                                    .aspectRatio(contentMode: .fill)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                
                                
                                VStack(alignment: .leading) {
                                    
                                    Text(note.name ?? "")
                                        .foregroundColor(.black)
                                        .fontWeight(.semibold)
                                    
                                    Text("\(note.chapter ?? "")")
                                        .foregroundColor(.gray)
                                        .font(.system(size: 13))
                                    
                                    Spacer()
                                    
                                    HStack(spacing: 5) {
                                        Image(systemName: "star.fill")
                                            .resizable()
                                            .frame(width: 14, height: 14)
                                            .foregroundColor(Color("clr_purple_mimosa"))
                                        
                                        Text("\(String(format: "%.1f", note.rating))")
                                            .foregroundColor(Color("clr_purple_mimosa"))
                                            .font(.system(size: 12))
                                    }
                                    .padding([.leading,.trailing], 10)
                                    .padding([.top, .bottom], 5)
                                    .background(Color("clr_v_light_purple").cornerRadius(15))
                                    
                                    
                                }
                                
                                Spacer()
                                
                            }
                            .padding()
                            .background(Color.white.cornerRadius(10))
                            
                            
                        }
                        
                        Spacer()
                        
                    }
                    .padding()
                    
                }
            }
            
        }
        .onAppear{
            //vm.isLoading = true
            Task {
                await vm.fetchStandards()
            }
        }
        
        if vm.isLoading {
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                .scaleEffect(2)
        }
    }
    
}

struct DownloadedNotesView_Previews: PreviewProvider {
    static var previews: some View {
        DownloadedNotesView()
    }
}
