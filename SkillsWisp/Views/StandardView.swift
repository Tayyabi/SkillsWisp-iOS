//
//  MatricScreen.swift
//  SkillsWisp
//
//  Created by M Tayyab on 21/05/2023.
//

import SwiftUI

struct StandardView: View {
    
    
    @State var backgrounds: [String] = ["bg_physics","bg_chemistry","bg_maths","bg_cs"]
    @State private var counter: Int = 0
    
    @Environment(\.presentationMode) var presentationMode
    @StateObject var vm = StandardViewModel()
    
    var body: some View {
        
        NavigationView {
            
            ZStack {
                
                VStack(spacing: nil) {
                    
                    
                    ZStack {
                        
                        Image("bg_matric")
                            .aspectRatio(contentMode: .fit)
                            
                        
                        HStack {
                            
                            VStack(alignment: .leading, spacing: 6) {
                                
                                Button(action: {
                                    presentationMode.wrappedValue.dismiss()
                                }, label: {
                                    Image("ic_left_arrow")
                                        .padding(.bottom)
                                })
                                
                                
                                Text("Matriculation")
                                    .foregroundColor(.white)
                                    .fontWeight(.semibold)
                                    .font(.title2)
                                
                                Text("Get solved notes by top professors of Pakistan")
                                    .foregroundColor(.white)
                                    .font(.system(size: 14))
                                
                            }
                            
                            Image("ic_math")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 200, height: 200)
                            
                            
                        }
                        .frame(
                            minWidth: 0,
                            maxWidth: .infinity
                        )
                        
                        
                    }
                    
                    
                    //Spacer()
                    
                    
                    ScrollView(showsIndicators: false) {

                        ForEach(vm.savedEntities.indices, id: \.self) { index in

                            let subject = vm.savedEntities[index]
                                
                            
                            NavigationLink(destination: SubjectView(), label: {

                                ZStack {

                                    Image("\(backgrounds[index % backgrounds.count])")
                                                               .resizable()
                                    

                                    VStack {

                                        Text("\(subject.name ?? "")")
                                            .foregroundColor(.white)
                                            .fontWeight(.semibold)
                                            .frame(
                                                minWidth: 0,
                                                maxWidth: .infinity,
                                                alignment: .leading
                                            )

                                        Text("Get solved notes by top professors of Pakistan")
                                            .foregroundColor(.white)
                                            .font(.system(size: 14))
                                            .padding(.top, 0.7)
                                            .frame(
                                                minWidth: 0,
                                                maxWidth: .infinity,
                                                alignment: .leading
                                            )

                                    }
                                    .padding()

                                }
                                .padding([.leading,.trailing])
                            })

                           

                        }

                    }
                    
                }
                
            }
            .edgesIgnoringSafeArea([.leading, .trailing, .top])
            
        }
        .navigationBarBackButtonHidden(true)
        
    }
    
}

struct MatricScreen_Previews: PreviewProvider {
    static var previews: some View {
        StandardView()
    }
}
