//
//  AllDateSheets.swift
//  SkillsWisp
//
//  Created by M Tayyab on 08/09/2023.
//

import SwiftUI

struct AllDateSheetsView: View {
    
    @State var shouldNavigate = false
    
    @ObservedObject var paper = PassPaper()
    
    @StateObject var vm = AllDateSheetsViewModel()
    
    var body: some View {
        ZStack {
            
            ScrollView(showsIndicators: false) {
                
                VStack {
                    
                    
                    ForEach(vm.dateSheets.indices, id: \.self) { index in
                        
                        let dateSheet = vm.dateSheets[index]
                        
                        Button(action: {
                            paper.paper = dateSheet
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
                        })
                        
                    }
                    NavigationLink(destination: PastPaperDateSheetView(paper: paper),isActive: $shouldNavigate) {
                        EmptyView()
                    }
                    .hidden()
                    
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
