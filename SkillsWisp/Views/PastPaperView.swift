//
//  PastPaperView.swift
//  SkillsWisp
//
//  Created by M Tayyab on 08/09/2023.
//

import SwiftUI
class PassClass: ObservableObject {
    @Published var classs: PastPaperModel?
}


struct PastPaperView: View {
    
    @State var shouldNavigate = false
    @ObservedObject var passClass = PassClass()
    
    @StateObject var vm = PastPaperViewModel()
    
    var body: some View {
        ZStack {
            
            ScrollView(.vertical, showsIndicators: false)
            {
                VStack(alignment: .leading) {
                    
                    HStack {
                        Text("Matriculation")
                            .foregroundColor(.black)
                            .padding()
                        Spacer()
                        
                    }
                    .background(Color.gray.opacity(0.1))
                    
                    
                    ScrollView(.horizontal, showsIndicators: false)
                    {
                        HStack(spacing: 10){
                            
                            ForEach(vm.matric.indices, id: \.self) { index in
                                
                                let matric = vm.matric[index]
                                Button(action: {
                                    passClass.classs = matric
                                    shouldNavigate = true
                                }, label: {
                                    VStack {
                                        
                                        Image("ic_notes")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 45, height: 45)
                                            .padding(20)
                                            .background(Color("clr_v_light_purple").opacity(0.5).cornerRadius(radius: 10, corners: .allCorners))
                                        
                                        
                                        Text("\(matric.classs ?? "")")
                                            .foregroundColor(.black)
                                            .font(.system(size: 14))
                                        
                                        
                                    }
                                    
                                })
                            }
                        }
                        .padding()
                        
                        
                    }
                    
                    
                    HStack {
                        Text("Intermediate")
                            .foregroundColor(.black)
                            .padding()
                        Spacer()
                        
                    }
                    .background(Color.gray.opacity(0.1))
                    
                    
                    ScrollView(.horizontal, showsIndicators: false)
                    {
                        HStack(spacing: 10){
                            
                            ForEach(vm.intermediate.indices, id: \.self) { index in
                                
                                let intermediate = vm.intermediate[index]
                                Button(action: {
                                    passClass.classs = intermediate
                                    shouldNavigate = true
                                }, label: {
                                    VStack {
                                        
                                        Image("ic_notes_orange")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 45, height: 45)
                                            .padding(20)
                                            .background(Color("clr_light_orange").opacity(0.5).cornerRadius(radius: 10, corners: .allCorners))
                                        
                                        
                                        Text("\(intermediate.classs ?? "")")
                                            .foregroundColor(.black)
                                            .font(.system(size: 14))
                                    }
                                    
                                    
                                })
                                
                            }
                        }
                        .padding()
                        
                        
                    }
                    
                    
                    HStack {
                        Text("Bachelors")
                            .foregroundColor(.black)
                            .padding()
                        Spacer()
                        
                    }
                    .background(Color.gray.opacity(0.1))
                    
                    
                    ScrollView(.horizontal, showsIndicators: false)
                    {
                        HStack(spacing: 10){
                            
                           
                            ForEach(vm.bachelors.indices, id: \.self) { index in
                                
                                let bachelors = vm.bachelors[index]
                                Button(action: {
                                    passClass.classs = bachelors
                                    shouldNavigate = true
                                }, label: {
                                    VStack {
                                        
                                       
                                        
                                        Image("ic_notes_green")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 45, height: 45)
                                            .padding(20)
                                            .background(Color("clr_aqua_squeeze").opacity(0.5).cornerRadius(radius: 10, corners: .allCorners))
                                        
                                        
                                        Text("\(bachelors.classs ?? "")")
                                            .foregroundColor(.black)
                                            .font(.system(size: 14))
                                    }
                                    
                                })
                                
                            }
                            
                        }
                        .padding()
                        
                        
                    }
                    
                    Spacer()
                    
                }
            }
            
        }
        .onAppear{
            Task {
                await vm.fetchPastPapersFromDB()
            }
        }
        .navigationDestination(isPresented: $shouldNavigate) {
            SubjectListView(passClass: passClass)
        }
    }
}

struct PastPaperView_Previews: PreviewProvider {
    static var previews: some View {
        PastPaperView(passClass: PassClass())
    }
}
