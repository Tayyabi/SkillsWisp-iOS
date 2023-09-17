//
//  HomeScreen.swift
//  SkillsWisp
//
//  Created by M Tayyab on 20/05/2023.
//
import SwiftUI

class DataStore: ObservableObject {
    @Published var id: String?
}

struct HomeView: View {
    
    @StateObject private var dataStore = StandSubjNoteDataStore()
    
    @State var icons: [String] = ["ic_matric","ic_inter","ic_bachelors"]
    @State var backgrounds: [String] = ["clr_aqua_squeeze","clr_yellow_green","clr_tropical_blue"]
    
    @State var notes: String = ""
    @State var shouldNavigate = false
    @State var navigatePastPaper = false
    
    @StateObject var vm = HomeViewModel()
    
    let columns: [GridItem] = [
        
        GridItem(.flexible(), spacing: 15, alignment: nil),
        GridItem(.flexible(), spacing: 15, alignment: nil),
    ]
    
    var body: some View {
        
        NavigationStack {
            
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
                                            
                                            ForEach(vm.savedEntities.indices, id: \.self) { index in
                                                
                                                let standard = vm.savedEntities[index]
                                                
                                                VStack {
                                                    
                                                    Button(action: {
                                                        if let standard_id = standard.standardId {
                                                            dataStore.standard_id = standard_id
                                                            shouldNavigate = true
                                                        }
                                                        
                                                        
                                                    }, label: {
                                                        VStack {
                                                            
                                                            Image("\(icons[index % icons.count])")
                                                                .resizable()
                                                                .aspectRatio(contentMode: .fit)
                                                                .frame(width: 100, height: 100)
                                                            Text("\(standard.name ?? "")")
                                                                .foregroundColor(.black)
                                                                .font(.system(size: 14))
                                                        }
                                                        .padding()
                                                        .background(
                                                            Color("\(backgrounds[index % backgrounds.count])")
                                                                .cornerRadius(10)
                                                        )
                                                    })
                                                    
                                                    
                                                }.padding(.trailing,10)
                                            }
                                            
            //                                NavigationLink(destination:StandardView(dataStore: dataStore),isActive: $shouldNavigate) {
            //                                    EmptyView()
            //                                }
            //                                .hidden()
                                        }
                                    }
                                    .frame(height: 150)
                                    
                                    Text("Explore more options")
                                        .fontWeight(.semibold)
                                        .padding(.top)
                                    
                                    LazyVGrid(
                                        columns: columns,
                                        spacing: 15,
                                        pinnedViews: [],
                                        content: {
                                            
                                            Group {
                                                
                                                
                                                NavigationLink(destination: DownloadedNotesView(), label: {
                                                    
                                                    HStack {
                                                        
                                                        Image("ic_downloads")
                                                            .resizable()
                                                            .frame(width: 20, height: 20)
                                                            .padding(8)
                                                            .background(Color("clr_v_light_purple")
                                                                .cornerRadius(radius: 6, corners: .allCorners))
                                                        
                                                        Text("Downloads")
                                                            .font(.system(size: 14))
                                                            .foregroundColor(.black)
                                                            .padding(.leading)
                                                        
                                                    }
                                                })
                                                
                                                
                                                NavigationLink(destination: BookmarkView(), label: {
                                                    HStack {
                                                        
                                                        Image(systemName: "bookmark.fill")
                                                            .foregroundColor(.red)
                                                            .frame(width: 20, height: 20)
                                                            .padding(8)
                                                            .background(Color("clr_pale_pink")
                                                                .cornerRadius(radius: 6, corners: .allCorners))
                                                        
                                                        
                                                        Text("Bookmarked")
                                                            .font(.system(size: 14))
                                                            .foregroundColor(.black)
                                                            .padding(.leading)
                                                        
                                                    }
                                                })
                                                
                                                NavigationLink(destination: AllDateSheetsView(), label: {
                                                    HStack {
                                                        
                                                        Image("ic_date_sheet")
                                                            .resizable()
                                                            .frame(width: 20, height: 20)
                                                            .padding(8)
                                                            .background(Color("clr_light_orange")
                                                                .cornerRadius(radius: 6, corners: .allCorners))
                                                        
                                                        
                                                        Text("Date Sheet")
                                                            .font(.system(size: 14))
                                                            .foregroundColor(.black)
                                                            .padding(.leading)
                                                        
                                                    }
                                                })
                                                
                                                
                                                Button(action: {
                                                    navigatePastPaper = true
                                                }, label: {
                                                    HStack {
                                                        
                                                        Image("ic_past_paper")
                                                            .resizable()
                                                            .frame(width: 20, height: 20)
                                                            .padding(8)
                                                            .background(Color("clr_tropical_blue").cornerRadius(radius: 6, corners: .allCorners))
                                                        
                                                        Text("Past Papers")
                                                            .font(.system(size: 14))
                                                            .foregroundColor(.black)
                                                            .padding(.leading)
                                                        
                                                    }
                                                })
                                                    
                                                //})
                                                
                                                
                                                
                                            }
                                            .frame(
                                                minWidth: 0,
                                                maxWidth: .infinity
                                            )
                                            .padding()
                                            .background(Color.white.cornerRadius(radius: 6, corners: .allCorners))
                                            .shadow(radius: 1)
                                            
                                        })
                                    
                                    Text("Popular Notes")
                                        .fontWeight(.semibold)
                                        .padding(.top)
                                    
                                    
                                    ScrollView(.horizontal, showsIndicators: false)
                                    {
                                        
                                        HStack {
                                            
                                            ForEach(1..<5, id: \.self) { index in
                                                
                                                //let standard = self.classes[index]
                                                NavigationLink(destination: {}, label: {
                                                    
                                                    VStack(alignment: .leading, spacing: 10) {
                                                        
                                                        HStack(alignment: .center) {
                                                            
                                                            Image("ic_notes")
                                                            
                                                            Spacer()
                                                            
                                                            Image(systemName: "star.fill")
                                                                .foregroundColor(.yellow)
                                                            Text("4.9")
                                                                .foregroundColor(.black)
                                                                .font(.system(size: 14))
                                                        }
                                                        
                                                        Text("9th Class Notes by Ali Asfand")
                                                            .font(.system(size: 16))
                                                            .fontWeight(.semibold)
                                                            .frame(maxWidth: .infinity, alignment: .leading)
                                                            .foregroundColor(.black)
                                                            .padding(.top)
                                                        
                                                        Text("14 Chapters | Solved Excercise")
                                                            .font(.system(size: 14))
                                                            .foregroundColor(.gray)
                                                    }
                                                    .padding()
                                                    .background(
                                                        RoundedRectangle(cornerRadius: 10)
                                                            .stroke(Color("clr_purple_mimosa"), lineWidth: 1.5)
                                                    )
                                                    .padding(5)
                                                    
                                                })
                                            }
                                            
                                        }
                                    }
                                    .frame(height: 150)
                                    
                                    
                                    Spacer()
                                }
                                .padding([.leading, .trailing])
                                
                                
                                
                            }
            }
            .onAppear{
                Task {
                    await vm.fetchStandardsFromDB()
                }
            }
            .navigationDestination(isPresented: $shouldNavigate) {
                StandardView(dataStore: dataStore)
            }
            .navigationDestination(isPresented: $navigatePastPaper) {
                PastPaperView()
            }
            
            .navigationBarItems(
                leading: NavigationLink(destination: SettingsView(), label: {
                    Image("ic_menu")
                        .resizable()
                        .frame(width: 30, height: 30)
                    
                }),
                trailing: NavigationLink(destination: ProfileView(),label: {
                    
                    /*Image("ic_profile")
                     .resizable()
                     .clipShape(Circle())
                     .frame(width: 35, height: 35)
                     .shadow(radius: 10)*/
                    let picture_url = UserDefaults.standard.string(forKey: "picture_url") ?? ""
                    RemoteImage(url: URL(string: picture_url))
                        .clipShape(Circle())
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 40, height: 40)
                    
                })
            )
        }
        .navigationBarHidden(true)
        
        
        
        
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
