//
//  SubjectListView.swift
//  SkillsWisp
//
//  Created by M Tayyab on 08/09/2023.
//

import SwiftUI

struct SubjectListView: View {
    
    @State var shouldNavigate = false
    @State var selectedYear = 2023
    @State var years = [2023,2022,2021,2020]
    @StateObject var vm = SubjectListViewModel()
    
    var body: some View {
        ZStack {
            VStack {
                ScrollView(showsIndicators: false) {
                    
                    VStack {
                        
                        HStack {
                            
                            ForEach(years.indices, id: \.self) {index in
                                
                                let year = years[index]
                                Button(action: {
                                    
                                    selectedYear = year
                                    
                                }, label: {
                                    Text(verbatim: "\(year)")
                                        .foregroundColor(selectedYear == year ? .white: .gray)
                                        .fontWeight(.semibold)
                                        .font(.system(size: 15))
                                        .padding(12)
                                        .background(
                                            selectedYear == year ? AnyView(
                                                
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
                            
                        }
                        
                        ForEach(vm.subjects.indices, id: \.self) { index in
                            
                            let subject = vm.subjects[index]
                            
                            Button(action: {
                                shouldNavigate = true
                            }, label: {
                                VStack {
                                    
                                    HStack {
                                        
                                        Image("ic_past_paper")
                                            .resizable()
                                            .frame(width: 20, height: 20)
                                            .padding(10)
                                            .background(Color("clr_tropical_blue")
                                                .cornerRadius(radius: 6, corners: .allCorners))
                                        
                                        
                                        HStack(alignment: .center) {
                                            
                                            Text("\(subject.name ?? "")")
                                                .font(.system(size: 15))
                                                .fontWeight(.semibold)
                                                .foregroundColor(.black)
                                            
                                            Spacer()
                                            
                                        }
                                        
                                        NavigationLink(destination: DateSheetView(),isActive: $shouldNavigate) {
                                            EmptyView()
                                        }
                                        .hidden()
                                        
                                    }
                                    .padding(10)
                                    
                                    
                                    Divider()
                                        .padding([.leading, .trailing], 15)
                                    
                                    
                                }
                            })
                            
                        }
                        
                    }
                    .padding(10)
                }
            }
            
        }
        .onAppear{
            Task {
                await vm.fetchSubjectsFromDB()
            }
        }
    }
}

struct SubjectListView_Previews: PreviewProvider {
    static var previews: some View {
        SubjectListView()
    }
}
