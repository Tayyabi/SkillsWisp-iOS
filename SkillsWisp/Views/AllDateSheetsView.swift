//
//  AllDateSheets.swift
//  SkillsWisp
//
//  Created by M Tayyab on 08/09/2023.
//

import SwiftUI

struct AllDateSheetsView: View {
    
    @State var shouldNavigate = false
    
    @StateObject var vm = AllDateSheetsViewModel()
    
    var body: some View {
        ZStack {
            
            ScrollView(showsIndicators: false) {
                
                VStack {
                    
                    
                    ForEach(vm.dateSheets.indices, id: \.self) { index in
                        
                        let dateSheet = vm.dateSheets[index]
                        
                        Button(action: {
                            shouldNavigate = true
                        }, label: {
                            VStack {
                                
                                HStack {
                                    
                                    Image("ic_date_sheet")
                                        .resizable()
                                        .frame(width: 20, height: 20)
                                        .padding(10)
                                        .background(Color("clr_light_orange")
                                            .cornerRadius(radius: 6, corners: .allCorners))
                                    
                                    
                                    HStack(alignment: .center) {
                                        
                                        Text("\(dateSheet.classs ?? "" )")
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
            }
            
        }
        .onAppear {
            
            Task {
                await vm.fetchDateSheetsFromDB()
            }
        }
    }
}

struct AllDateSheets_Previews: PreviewProvider {
    static var previews: some View {
        AllDateSheetsView()
    }
}
