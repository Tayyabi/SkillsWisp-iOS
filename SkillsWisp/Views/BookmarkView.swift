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
                    VStack(alignment: .leading, spacing: 10) {
                        
                        if(selectedOption == "All" || selectedOption == "Notes") {
                            Text("Notes")
                                .fontWeight(.semibold)
                                .font(.system(size: 15))
                            
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
            if vm.isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                    .scaleEffect(2)
            }
        }
        
        .onAppear{
            
            guard vm.isLogin else {
                print("Please login first")
                return
            }
            
            vm.isLoading = true
            Task {
                await vm.fetchNotes()
                await vm.fetchPastPapers()
                await vm.fetchDateSheets()
            }
        }
    }
}

struct BookmarkScreen_Previews: PreviewProvider {
    static var previews: some View {
        BookmarkView()
    }
}
