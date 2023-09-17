//
//  DownloadedNotesView.swift
//  SkillsWisp
//
//  Created by M Tayyab on 05/09/2023.
//

import SwiftUI

struct DownloadsView: View {
    
    @State var thumbnails: [String] = ["bn_class_1","bn_class_2", "bn_class_3", "bn_class_4"]
    @State var selectedOption = "All"
    @State var options = ["All","Notes","Past Papers","Date Sheet"]
    
    @StateObject var vm = DownloadsViewModel()
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
                    
                    VStack(alignment: .leading, spacing: 10) {
                        
                        if(selectedOption == "All" || selectedOption == "Notes") {
                            Text("Notes")
                                .fontWeight(.semibold)
                                .font(.system(size: 15))
                            
                            
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
                        }
                        
                        if(selectedOption == "All" || selectedOption == "Past Papers") {
                            
                            Text("Past Papers")
                                .fontWeight(.semibold)
                                .font(.system(size: 15))
                            
                            
                            ForEach(vm.pastPapers.indices, id: \.self){ index in
                                
                                let pastPaper = vm.pastPapers[index]
                                
                                VStack {
                                    
                                    HStack {
                                        
                                        Image("ic_past_paper")
                                            .resizable()
                                            .frame(width: 20, height: 20)
                                            .padding(10)
                                            .background(Color("clr_tropical_blue")
                                                .cornerRadius(radius: 6, corners: .allCorners))
                                        
                                        
                                        HStack(alignment: .center) {
                                            
                                            Text("\(pastPaper.name ?? "")")
                                                .font(.system(size: 15))
                                                .fontWeight(.semibold)
                                                .foregroundColor(.black)
                                            
                                            Spacer()
                                            
                                        }
                                        
                                    }
                                    .padding(10)
                                    
                                    
                                    Divider()
                                        .padding([.leading, .trailing], 15)
                                    
                                    
                                }
                                
                            }
                        }
                        
                        
                        if(selectedOption == "All" || selectedOption == "Date Sheet") {
                            Text("Date Sheets")
                                .fontWeight(.semibold)
                                .font(.system(size: 15))
                            
                            
                            ForEach(vm.dateSheets.indices, id: \.self){ index in
                                
                                let dateSheet = vm.dateSheets[index]
                                
                                VStack {
                                    
                                    HStack {
                                        
                                        Image("ic_date_sheet")
                                            .resizable()
                                            .frame(width: 20, height: 20)
                                            .padding(10)
                                            .background(Color("clr_light_orange")
                                                .cornerRadius(radius: 6, corners: .allCorners))
                                        
                                        
                                        HStack(alignment: .center) {
                                            
                                            Text("\(dateSheet.name ?? "" )")
                                                .font(.system(size: 15))
                                                .fontWeight(.semibold)
                                                .foregroundColor(.black)
                                            
                                            Spacer()
                                            
                                        }
                                        
                                    }
                                    .padding(10)
                                    
                                    
                                    Divider()
                                        .padding([.leading, .trailing], 15)
                                    
                                    
                                }
                                
                            }
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
        DownloadsView()
    }
}
